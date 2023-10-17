// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home_page.dart';
import 'Add_user.dart';
import 'map_device.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Widget> buttons = [];

  Future<List<String>>? deviceIds;

  @override
  void initState() {
    super.initState();
    deviceIds = fetchDeviceIds();
  }

  Future<List<String>> fetchDeviceIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/user/getInfo'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> deviceIdsJson = jsonResponse["deviceIds"];

      if (deviceIdsJson is List) {
        final deviceIds = deviceIdsJson.map((deviceIdJson) => deviceIdJson.toString()).toList();
        return deviceIds;
      } else {
        return <String>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load device IDs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: deviceIds,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final deviceIdsList = snapshot.data;

          if (deviceIdsList == null || deviceIdsList.isEmpty) {
            return Center(child: Text('No device IDs found.'));
          }

          return Drawer(
            
            child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset("assets/logo.png"),
              ),
              Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Adduser()),);
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 60),
                              Icon(Icons.person_add, color: Colors.green),
                              SizedBox(width: 8),
                              Text('add_user'.tr, style: TextStyle(color: Colors.green)),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0.9),
                            onPrimary: Colors.black,
                            fixedSize: Size(250, 60),
                            side: BorderSide(
                              color: Colors.green,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mapdevice()),);
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 60),
                              SizedBox(width: 8),
                              Text('map_device'.tr, style: TextStyle(color: Colors.green)),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            fixedSize: Size(250, 60),
                            side: BorderSide(
                              color: Colors.green,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
              ListView.builder(
                shrinkWrap: true, 
                itemCount: deviceIdsList.length,
                itemBuilder: (context, index) {
                  
              
                 return  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()),);
// 
                                // Handle button press for each device
                                // You can navigate to a specific page or perform other actions here
                              },
                              child: Row(
                                children: [
                                  Text(
                'device_no:1'.tr,
                style: TextStyle(color: const Color.fromARGB(255, 195, 51, 41),),
              ),
                                  Text(
                                    deviceIdsList[index],
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 195, 51, 41),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(223, 240, 200, 200),
                                fixedSize: Size(770, 60),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 218, 117, 110),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              Spacer(),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // _showAddDeviceDialog(context);
                              },
                              child: Row(
                                children: [
                                  SizedBox(width: 60),
                                  Icon(Icons.add, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('add_device'.tr),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                fixedSize: Size(100, 60),
                                side: BorderSide(
                                  color: Colors.green,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
            ]
            ),
            
          );
        }
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<String>>(
  //     future: deviceIds,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else {
  //         final deviceIdsList = snapshot.data;

  //         if (deviceIdsList == null || deviceIdsList.isEmpty) {
  //           return Center(child: Text('No device IDs found.'));
  //         }

  //         return Drawer(
  //           backgroundColor: Colors.white,
  //           child: ListView.builder(
  //             itemCount: deviceIdsList.length,
  //             itemBuilder: (context, index) {
  //               return Card(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(top: 60, bottom: 30, left: 30, right: 30),
  //                       child: Center(
  //                         child: Container(
  //                           child: Image.asset("assets/logo.png"),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 15, right: 15),
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Adduser()),);
  //                         },
  //                         child: Row(
  //                           children: [
  //                             SizedBox(width: 60),
  //                             Icon(Icons.person_add, color: Colors.green),
  //                             SizedBox(width: 8),
  //                             Text('add_user'.tr, style: TextStyle(color: Colors.green)),
  //                           ],
  //                         ),
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Colors.white.withOpacity(0.9),
  //                           onPrimary: Colors.black,
  //                           fixedSize: Size(250, 60),
  //                           side: BorderSide(
  //                             color: Colors.green,
  //                             width: 2,
  //                             style: BorderStyle.solid,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 15,),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 15, right: 15),
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mapdevice()),);
  //                         },
  //                         child: Row(
  //                           children: [
  //                             SizedBox(width: 60),
  //                             SizedBox(width: 8),
  //                             Text('map_device'.tr, style: TextStyle(color: Colors.green)),
  //                           ],
  //                         ),
  //                         style: ElevatedButton.styleFrom(
  //                           primary: Colors.white,
  //                           fixedSize: Size(250, 60),
  //                           side: BorderSide(
  //                             color: Colors.green,
  //                             width: 2,
  //                             style: BorderStyle.solid,
  //                           ),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(16.0),
  //                       child: Container(
  //                         height: 400,
  //                         width: 250,
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             children: [
  //                               Padding(
  //                                 padding: EdgeInsets.only(left: 5, right: 5, top: 10),
  //                                 child: ElevatedButton(
  //                                   onPressed: () {
  //                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()),);
  //                                   },
  //                                   child: Row(
  //                                     children: [
  //                                       Text(
  //                                         deviceIdsList[index],
  //                                         style: TextStyle(
  //                                           color: const Color.fromARGB(255, 195, 51, 41),
  //                                           fontSize: 15,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   style: ElevatedButton.styleFrom(
  //                                     primary: Color.fromARGB(223, 240, 200, 200),
  //                                     fixedSize: Size(770, 60),
  //                                     side: BorderSide(
  //                                       color: Color.fromARGB(255, 218, 117, 110),
  //                                       width: 2,
  //                                       style: BorderStyle.solid,
  //                                     ),
  //                                     shape: RoundedRectangleBorder(
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
                      
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  void _showAddDeviceDialog(BuildContext context) {
    final _deviceController = TextEditingController();
    final _devicenameController = TextEditingController();
    final _pinController = TextEditingController();
    final _simController = TextEditingController();
    final _topiccontroller = TextEditingController();
    final _zonecontroller = TextEditingController();
    final _serialNocontroller = TextEditingController();
    final _mobileNocontroller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (context) {
            return Scaffold(
              bottomNavigationBar: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('https://console-api.theja.in/admin/addDevice');
                    final jsonData = {
                      "active": true,
                      "deviceId": _deviceController.text,
                      "deviceSerialNumber": _serialNocontroller.text,
                      "name": _devicenameController.text,
                      "simId": _simController.text,
                      "topic": _topiccontroller.text,
                      "zone": _zonecontroller.text,
                    };

                    final jsonString = json.encode(jsonData);

                    final headers = {
                      "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI4NTAWOTMwMDg4IiwiYXV0aG9yaXRpZXMiOlsidXNlciJdLCJ1aWQiOjk2ODYsImlhdCI6MTY5NzExODQyMiwiZXhwIjoxNzI4NjU0NDIyfQ.8XCTMjvBY65rKT_xqRTymRlD5K5IdgN5dwjz0hUPEP5oC2AJQw_N22y4PGV538NsiegYjZNIIKVddZ84X1zmyg"
                    };

                    final response = await http.post(url, headers: headers, body: jsonString);

                    if (response.statusCode == 200) {
                      // Successful response, you can handle it as per your requirement.
                      print("Device added successfully");
                    } else {
                      // Error response, display an error message or handle it as needed.
                      print("Failed to add device. Status Code: ${response.statusCode}");
                      print("Response Body: ${response.body}");
                    }
                    Navigator.of(context).pop();

                    // Close the dialog after handling the response.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Text('add_device'.tr, style: TextStyle(fontSize: 20)),
                ),
              ),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Text(
                  'add_device'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        'device_id'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _deviceController,
                        decoration: InputDecoration(
                          hintText: 'enter_device_id'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'device_name'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _devicenameController,
                        decoration: InputDecoration(
                          hintText: 'enter_device_name'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'pin'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _pinController,
                        decoration: InputDecoration(
                          hintText: 'enter_device_pin'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'sim',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _simController,
                        decoration: InputDecoration(
                          hintText: 'enter_device_sim'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'topic'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _topiccontroller,
                        decoration: InputDecoration(
                          hintText: 'enter_topic'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'zone'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _zonecontroller,
                        decoration: InputDecoration(
                          hintText: 'enter_zone'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'device_serial-no'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _serialNocontroller,
                        decoration: InputDecoration(
                          hintText: 'enter_serial_no'.tr,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'mobile_number'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _mobileNocontroller,
                        decoration: InputDecoration(
                          hintText: 'enter_mobile_number'.tr,
                        ),
                      ),
                      SizedBox(height: 90,),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
