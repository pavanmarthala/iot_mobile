import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/pages/admin_landing_pages/Add_user.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/add_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_device.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
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

class Mapdevices extends StatefulWidget {
  const Mapdevices({Key? key}) : super(key: key);

  @override
  State<Mapdevices> createState() => _MapdevicesState();
}

class _MapdevicesState extends State<Mapdevices> {
  List<User> users = [];
  List<Device> devices = [];
  List<User> searchedUsers = [];
  List<Device> searchedDevices = [];

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
      searchedDevices.clear();
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
      searchedUsers.clear();
    });
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
      // return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('User and Device Selection'),
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
            // User container with search box
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // User container text
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'User ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Search box
                      Container(
                        height: 32,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: 230,
                        child: TextField(
                          onChanged: searchUsers,
                          decoration: InputDecoration(
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
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Expanded(
                          child: ListView(
                            children: searchedUsers.map((user) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                    ),
                                    child: Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 20,
                                    ),
                                    child: Text(
                                      user.mobile,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Device container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Device container text
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Device ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // Search box
                      Container(
                        height: 32,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 230,
                        child: TextField(
                          onChanged: searchDevices,
                          decoration: InputDecoration(
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
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Expanded(
                          child: ListView(
                            children: searchedDevices.map((device) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                    ),
                                    child: Text(
                                      device.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 20,
                                    ),
                                    child: Text(
                                      device.deviceId,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Save button
            ElevatedButton(
              onPressed: () {
                // Save user and device selection
              },
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(234, 42, 228, 138),
                fixedSize: const Size(220, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 85,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Adminlandingpage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Adduser(),
                            ),
                          );
                        },
                        child: const Text(
                          'ADD User',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddDevice(),
                            ),
                          );
                        },
                        child: const Text(
                          'Add Device',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Mapdevice(),
                            ),
                          );
                        },
                        child: const Text(
                          'Map Device',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
