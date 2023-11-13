// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/Add_user.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/add_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_device.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String mobile;
  final String name;

  User(this.mobile, this.name);
}

class Device {
  final String deviceId;
  final String name;

  Device(this.deviceId, this.name);
}

class MapDevices extends StatefulWidget {
  const MapDevices({Key? key}) : super(key: key);

  @override
  _MapDevicesState createState() => _MapDevicesState();
}

class _MapDevicesState extends State<MapDevices> {
  List<User> users = [];
  List<Device> devices = [];
  List<User> searchedUsers = [];
  List<Device> searchedDevices = [];
  List<String> selectedUserMobiles = [];
  List<String> selectedDeviceIds = [];
  List<String> selectedDeviceNames = [];

  void searchUsers(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchedUsers = users
            .where((user) =>
                user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.mobile.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchedUsers.clear();
      }
      // searchedDevices.clear();
    });
  }

  void searchDevices(String query) {
    setState(() {
      if (query.isNotEmpty) {
        searchedDevices = devices
            .where((device) =>
                device.name.toLowerCase().contains(query.toLowerCase()) ||
                device.deviceId.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        searchedDevices.clear();
      }
      // searchedUsers.clear();
    });
  }

  void selectUser(String mobile) {
    setState(() {
      if (selectedUserMobiles.contains(mobile)) {
        selectedUserMobiles.remove(mobile);
      } else {
        selectedUserMobiles.add(mobile);
      }
    });
  }

  void selectDevice(String deviceId) {
    setState(() {
      if (selectedDeviceIds.contains(deviceId)) {
        selectedDeviceIds.remove(deviceId);
      } else {
        selectedDeviceIds.add(deviceId);
        selectedDeviceNames.add(getDeviceName(deviceId));
      }
    });
  }

  String getDeviceName(String deviceId) {
    // Find and return the device name from the devices list
    final device = devices.firstWhere((device) => device.deviceId == deviceId,
        orElse: () => Device('', ''));
    return device.deviceId;
  }

  Future<void> mapDevices() async {
    // Iterate over selected users and devices and send API requests
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      return;
    }

    for (String mobile in selectedUserMobiles) {
      for (String deviceId in selectedDeviceIds) {
        try {
          final response = await http.post(
            Uri.parse(
                'https://console-api.theja.in/admin/mapDevice/$deviceId/$mobile'),
            headers: {
              "Authorization": "Bearer $jwtToken",
              "Content-Type": "application/json",
            },
          );

          if (response.statusCode == 200) {
            // Successfully mapped the device to the user
            // You can add further handling if needed
            print('Mapped successfully');
          } else {
            throw Exception(
                'Failed to map device. Status code: ${response.statusCode}');
          }
        } catch (e) {
          throw Exception('Failed to map device. Error: $e');
          // Handle the error gracefully, e.g., by displaying a dialog with the error message
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text('Error'),
          //       content:
          //           Text('Failed to map the device. Please try again later.'),
          //       actions: [
          //         TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: Text('OK'),
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
      }
    }
  }

  Future<void> sendNotification(String userId) async {
    var deviceNames = selectedDeviceNames.join(', ');
    try {
      // Retrieve the token from Firestore based on the user ID
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('UserTokens')
              .doc(userId)
              .get();

      if (userSnapshot.exists) {
        String? deviceToken = userSnapshot.data()?['token'];

        if (deviceToken != null) {
          var data = {
            'to': deviceToken,
            'notification': {
              'title': 'New Device Update',
              'body': 'Device: $deviceNames ' + 'Added to your Account',
            },
            'android': {
              'notification': {
                'notification_count': 23,
              },
            },
            'data': {'type': 'message', 'id': 'pavan'}
          };

          await http.post(
            Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  'key=AAAALbfocX4:APA91bFVgtoqpq0gwRcp1016R45Pts1pQFFGWJzXozyEslix8VE1m1ZtyBCH7ueldVPeHvXqKTsGz9iTqHKE5hhsTZf9fUMeuA-3EAYl3Bqh9bW806x5AUN2B_9l1LrLWTrK5aUoVGia'
            },
          );

          print('Notification sent successfully');
        } else {
          print('Device token not found for user: $userId');
        }
      } else {
        print('User not found in Firestore for ID: $userId');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserAndDeviceData();
  }

  Future<void> fetchUserAndDeviceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      return;
    }

    try {
      final userResponse = await http.get(
        Uri.parse('https://console-api.theja.in/admin/getAllUsers'),
        headers: {
          "Authorization": "Bearer $jwtToken",
        },
      );

      if (userResponse.statusCode == 200) {
        users = parseUserData(userResponse.body);
      } else {
        throw Exception(
            'Failed to load users. Status code: ${userResponse.statusCode}');
      }

      final deviceResponse = await http.get(
        Uri.parse('https://console-api.theja.in/admin/getAllDevices'),
        headers: {
          "Authorization": "Bearer $jwtToken",
        },
      );

      if (deviceResponse.statusCode == 200) {
        devices = parseDeviceData(deviceResponse.body);
      } else {
        throw Exception(
            'Failed to load devices. Status code: ${deviceResponse.statusCode}');
      }

      setState(() {});
    } catch (e) {
      throw Exception('Failed to load data. Error: $e');
    }
  }

  List<User> parseUserData(String responseBody) {
    final List<dynamic> data = json.decode(responseBody) as List<dynamic>;

    if (data == null) {
      throw Exception('API response is null');
    }

    List<User> users = data
        .map((user) => User(
              user['mobile'].toString(),
              user['userDetails']['name'].toString(),
            ))
        .toList();

    return users;
  }

  List<Device> parseDeviceData(String responseBody) {
    final List<dynamic> data = json.decode(responseBody) as List<dynamic>;

    List<Device> devices = data
        .map((device) => Device(
              device['deviceId'].toString(),
              device['name'].toString(),
            ))
        .toList();

    return devices;
  }

  FirebaseApi firebaseApi = FirebaseApi();

  @override
  Widget build(BuildContext context) {
    // Set to your desired value

    // if (customHeight < MediaQuery.of(context).size.width * 0.3) {
    //   customHeight = MediaQuery.of(context).size.width * 0.3;
    // }
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.green,
        title: Text(
          "map_user_to_device".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Langscreen(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.green,

                // backgroundImage: AssetImage('assets/language-icon.png'),
                child: SvgPicture.asset(
                  'assets/language-icon.svg',
                  // width: 100.0, // Adjust the width as needed
                  // height: 100.0, // Adjust the height as needed
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          'user'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        margin: const EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          onChanged: searchUsers,
                          decoration: InputDecoration(
                            hintText: 'search_for_users'.tr,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color.fromARGB(255, 251, 247, 247),
                            filled: true,
                            suffixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (searchedUsers.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchedUsers.length,
                        itemBuilder: (context, index) {
                          final user = searchedUsers[index];
                          final selected =
                              selectedUserMobiles.contains(user.mobile);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, top: 10),
                                  child: Text(
                                    user.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, bottom: 13),
                                  child: Text(
                                    user.mobile,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  selectUser(user.mobile);
                                },
                                leading: Icon(
                                  selected ? Icons.check_circle : Icons.circle,
                                  color: selected ? Colors.green : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          'device'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                      Container(
                        height: 32,
                        margin: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          onChanged: searchDevices,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            // hintText: 'Search for users',
                            hintText: 'search_for_device'.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: const Color.fromARGB(255, 246, 242, 242),
                            filled: true,
                            suffixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (searchedDevices.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchedDevices.length,
                        itemBuilder: (context, index) {
                          final device = searchedDevices[index];
                          final selected =
                              selectedDeviceIds.contains(device.deviceId);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, top: 10),
                                  child: Text(
                                    device.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45.0, bottom: 13),
                                  child: Text(
                                    device.deviceId,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  selectDevice(device.deviceId);
                                },
                                leading: Icon(
                                  selected ? Icons.check_circle : Icons.circle,
                                  color: selected ? Colors.green : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     mapDevices();
            //   },
            //   child: const Text('Save'),
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: Colors.black,
            //     backgroundColor: const Color.fromARGB(234, 42, 228, 138),
            //     fixedSize: const Size(220, 50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
            Center(
              child: AnimatedButton(
                  onTap: () {
                    mapDevices();
                    // sendNotification();
                    // Iterate over selected users and send notifications
                    selectedUserMobiles.forEach((userId) {
                      sendNotification(userId);
                    });

                    // firebaseApi.getDeviceToken().then((value) async {
                    //   var deviceNames = selectedDeviceNames.join(', ');
                    //   var data = {
                    //     'to': value.toString(),
                    //     'notification': {
                    //       'title': 'New Device Update',
                    //       'body':
                    //           'Device: $deviceNames ' + 'Added to your Account',
                    //     },
                    //     'android': {
                    //       'notification': {
                    //         'notification_count': 23,
                    //       },
                    //     },
                    //     'data': {'type': 'message', 'id': 'pavan'}
                    //   };

                    //   await http.post(
                    //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    //       body: jsonEncode(data),
                    //       headers: {
                    //         'Content-Type': 'application/json; charset=UTF-8',
                    //         'Authorization':
                    //             'key=AAAALbfocX4:APA91bFVgtoqpq0gwRcp1016R45Pts1pQFFGWJzXozyEslix8VE1m1ZtyBCH7ueldVPeHvXqKTsGz9iTqHKE5hhsTZf9fUMeuA-3EAYl3Bqh9bW806x5AUN2B_9l1LrLWTrK5aUoVGia'
                    //       }
                    //       //     ).then((value) {
                    //       //   if (kDebugMode) {
                    //       //     print(value.body.toString());
                    //       //   }
                    //       // }).onError((error, stackTrace) {
                    //       //   if (kDebugMode) {
                    //       //     print(error);
                    //       //   }
                    //       // }
                    //       );
                    // });

                    print("animated button pressed");
                  },
                  animationDuration: const Duration(milliseconds: 2000),
                  initialText: "map_user_to_device".tr,
                  finalText: "Mapped successful",
                  iconData: Icons.check,
                  iconSize: MediaQuery.of(context).size.width * 0.08,
                  buttonStyle: buttonstyle(
                    primaryColor: Colors.green.shade600,
                    secondaryColor: Colors.white,
                    initialTextStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.white,
                    ),
                    finalTextStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.green.shade600,
                    ),
                    elevation: 20.0,
                    borderRadius: 10.0,
                  )),
            ),
          ],
        ),
      ),

      // extendBody: true,
      // bottomNavigationBar: FloatingNavbar(
      //   onTap: (int val) {
      //     //returns tab id which is user tapped
      //   },
      //   currentIndex: 0,
      //   items: [
      //     FloatingNavbarItem(icon: Icons.home, title: 'Home'),
      //     FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
      //     FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
      //     FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
      //   ],
      // ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Adminlandingpage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.home)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Adduser(),
                      ),
                    );
                  },
                  icon: Icon(Icons.person_add)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddDevice(),
                      ),
                    );
                    //
                  },
                  icon: Icon(Icons.devices)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Mapdevice(),
                      ),
                    );
                  },
                  icon: Icon(Icons.device_hub_outlined)),
              // Container(
              //   // width: 85,
              //   // height: MediaQuery.of(context).size.height * 1.5,

              //   decoration: BoxDecoration(
              //     color: Colors.green,
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (context) => const Adminlandingpage(),
              //         ),
              //       );
              //     },
              //     child: Text(
              //       'Home',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: MediaQuery.of(context).size.width * 0.04,
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 8,
              //   ),
              //   child: Container(
              //     // width: 85,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => const Adduser(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         'Add User',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: MediaQuery.of(context).size.width * 0.03,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8),
              //   child: Container(
              //     // width: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => AddDevice(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         'Add Device',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: MediaQuery.of(context).size.width * 0.04,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8),
              //   child: Container(
              //     // width: MediaQuery.of(context).size.width * 0.2,
              //     // width: 100,

              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     child: TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => Mapdevice(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         'Map Device',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: MediaQuery.of(context).size.width * 0.04,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
