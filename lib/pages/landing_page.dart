// ignore_for_file: unnecessary_type_check

import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iot_mobile_app/pages/Drawer/Drawer.dart';
import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landingpage extends StatefulWidget {
  final String id;
  const Landingpage({Key? key, required this.id}) : super(key: key);

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
//   bool isSwitchedn = false;
//  bool motorbox = false;
//   bool powerStatusn = false;

  Future<List<Map<String, dynamic>>>? devices;

  @override
  void initState() {
    super.initState();

    devices = fetchDevices();
  }

  Future<List<Map<String, dynamic>>> fetchDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', 'device/getAll'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (jsonResponse is List) {
        final devices = jsonResponse.map((device) {
          return {
            "deviceId": device["deviceId"].toString(),
            "name": device["name"].toString(),
            "powerStatusn": device["powerAvailable"],
            "isSwitchedn": device["givenState"],
            "motorbox": device["deviceState"],
          };
        }).toList();
        return devices;
      } else {
        return <Map<String, dynamic>>[];
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
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "map_device".tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
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
                backgroundColor: Colors.white,

                // backgroundImage: AssetImage('assets/language-icon.png'),
                child: SvgPicture.asset(
                  'assets/language-icon.svg',
                  // width: 100.0, // Adjust the width as needed
                  // height: 100.0, // Adjust the height as needed
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Adminlandingpage()),
                    );
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
                children: deviceList.map((device) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20, left: 4, right: 4),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Homepage(device["deviceId"] ?? "")));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (Color.fromARGB(234, 203, 203, 203)),
                        onPrimary: Colors.black,
                        fixedSize: Size(402, 130),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'device_id:'.tr,
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                device["deviceId"] ?? "",
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(widget.id)
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'name'.tr,
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                device["name"] ?? "",
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 55,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: device["powerStatusn"]
                                        ? Colors.green
                                        : const Color.fromARGB(255, 253, 18, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("assets/power.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Container(
                                  height: 55,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: device["motorbox"]
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 253, 18, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/motor.jpeg"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Container(
                                  height: 55,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: device["isSwitchedn"]
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 253, 18, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: device["isSwitchedn"]
                                        ? Image.asset("assets/off.jpg")
                                        : Image.asset("assets/on.jpg"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
