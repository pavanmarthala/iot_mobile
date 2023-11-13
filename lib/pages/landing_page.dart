// ignore_for_file: unnecessary_type_check, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
// import 'package:iot_mobile_app/pages/Drawer/Drawer.dart';

import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  FirebaseApi firebaseApi = FirebaseApi();

  Future<List<Map<String, dynamic>>>? devices;
  late bool isAdminOrSuperAdmin;
  @override
  void initState() {
    super.initState();
    isAdminOrSuperAdmin = false;
    devices = fetchDevices();
    firebaseApi.initNotifications();
    firebaseApi.isTokenRefresh();
    firebaseApi.firebaseInit(context);
    firebaseApi.setupInteractMessage(context);
    firebaseApi.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    // checkUserRole();
  }

  Map<String, dynamic> decodeJwt(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      print('Error decoding JWT: $e');
      return {};
    }
  }

  Future<bool> checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken != null) {
      Map<String, dynamic> decodedToken = decodeJwt(jwtToken);
      List<dynamic> authorities = decodedToken['authorities'];

      return authorities.contains('admin') ||
          authorities.contains('superAdmin');
    }

    return false;
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
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        actions: [
          FutureBuilder<bool>(
            future: checkUserRole(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  return Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Adminlandingpage(),
                            ),
                          );
                        },
                        child: Icon(Icons.home)),
                  );
                }
              }
              return Container(); // Return an empty container if not admin or superadmin
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
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
                child: SvgPicture.asset(
                  'assets/language-icon.svg',
                ),
              ),
            ),
          )
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
                  return GestureDetector(
                    onTap: () async {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             // Homepage(device["deviceId"] ?? "")
                      //             Settings()));

                      Navigator.pushNamed(context, '/homepage',
                          arguments: device["deviceId"]);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 99,
                      height: 120,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 191, 188, 188),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  'device_id:'.tr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  device["deviceId"] ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  'name'.tr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  device["name"] ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Container(
                                  height: 45,
                                  // margin: EdgeInsets.symmetric(horizontal: 4),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: device["powerStatusn"]
                                          ? Colors.green
                                          : const Color.fromARGB(
                                              255, 253, 18, 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset("assets/power.png"),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                Container(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                              ],
                            ),
                          ],
                        ),
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
