// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_type_check

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home_page.dart';

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
        final deviceIds = deviceIdsJson
            .map((deviceIdJson) => deviceIdJson.toString())
            .toList();
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

          return Container(
            child: Center(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo.png"),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: deviceIdsList.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/homepage',
                                    arguments: deviceIdsList[index]);
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           Homepage(deviceIdsList[index])),
                                // );
                                //
                                // Handle button press for each device
                                // You can navigate to a specific page or perform other actions here
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'device_no:1'.tr,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 195, 51, 41),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                  Text(
                                    deviceIdsList[index],
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 195, 51, 41),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
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
              ]),
            ),
          );
        }
      },
    );
  }
}
