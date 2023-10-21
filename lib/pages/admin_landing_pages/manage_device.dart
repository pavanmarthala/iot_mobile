// ignore_for_file: unnecessary_type_check

import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/Add_user.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/add_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/edit.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_device.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Managedevice extends StatefulWidget {
  const Managedevice({super.key});

  @override
  State<Managedevice> createState() => _ManagedeviceState();
}

class _ManagedeviceState extends State<Managedevice> {
  Future<List<Map<String, String>>>? devices;

  @override
  void initState() {
    super.initState();
    devices = fetchDevices();
  }

  Future<List<Map<String, String>>> fetchDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/admin/getAllDeviceIds'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        final devices = jsonResponse.map((device) {
          return {
            "deviceId": device["deviceId"].toString(),
            "name": device["name"].toString(),
          };
        }).toList();
        return devices;
      } else {
        return <Map<String, String>>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load devices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mapping Device"),
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
        body: FutureBuilder<List<Map<String, String>>>(
          future: devices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final deviceList = snapshot.data;

              if (deviceList == null || deviceList.isEmpty) {
                return Center(child: Text('No devices found.'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: [
                            const Text("Device",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                height: 40,
                                width: 260,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors
                                          .grey, // Set the border color here
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey),
                                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      fillColor:
                                          Color.fromARGB(255, 251, 250, 250),
                                      filled: true,
                                      // hintText: 'search for devices',
                                      suffixIcon: Icon(Icons.search)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: deviceList.map((device) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Text(device["name"] ?? "",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, left: 20),
                                child: Text(device["deviceId"] ?? "",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         UserDetailsScreen(),
                                        //   ),
                                        // );
                                      },
                                      child: const Text('View',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: const Color.fromARGB(
                                            234, 42, 228, 138),
                                        fixedSize: const Size(120, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Delete',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              234, 239, 9, 9),
                                          onPrimary: Colors.black,
                                          fixedSize: const Size(120, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Activate/Deactivate',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              234, 239, 9, 9),
                                          onPrimary: Colors.black,
                                          fixedSize: const Size(120, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24))),
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

                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded border
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Adminlandingpage(),
                            ),
                          );

                          // Go back to Home Screen
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

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Adduser(),
                              ),
                            );

                            // Go back to Home Screen
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

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddDevice(),
                              ),
                            );

                            // Go back to Home Screen
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

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Mapdevice(),
                              ),
                            );

                            // Go back to Home Screen
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
        ));
  }
}
