// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unnecessary_type_check

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dash extends StatefulWidget {
  final String deviceId;

  Dash(this.deviceId, {super.key});
  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  bool isSwitched = false;
  var time = DateTime.now();
  DateTime motorSwitch = DateTime.now();
  DateTime motorStatus = DateTime.now();
  DateTime powerStatus = DateTime.now();

  Future<List<String>>? deviceIds;

  @override
  void initState() {
    super.initState();
    deviceIds = fetchDeviceIds();
  }

  Future<List<String>> fetchDeviceIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs
        .getString('jwt_token'); // Retrieve the JWT token from local storage

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https(
          'console-api.theja.in', '/user/getInfo'), // Use the correct endpoint
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
        // print(deviceIds[2]+'first index of device');
        return deviceIds;
      } else {
        return <String>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load device IDs');
    }
  }

  Future<List<String>> getdevice(deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs
        .getString('jwt_token'); // Retrieve the JWT token from local storage

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in',
          '/motor/get/${deviceId}'), // Use the correct endpoint
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

            final switchState = Provider.of<SwitchState>(context);

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'device_no:1'.tr,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.deviceId}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 140),
                        Container(
                          height: 30,
                          width: 30,
                          child: GestureDetector(
                              onTap:
                                  () {}, // Call handleRefresh when the icon is tapped
                              child: Image.asset(
                                "assets/refresh.png",
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 180,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 70,
                                  width: 380,
                                  decoration: BoxDecoration(
                                    color: switchState.isSwitched
                                        ? Colors.green
                                        : Color.fromARGB(255, 192, 27, 16),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'motor_switch'.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 120,
                                        ),
                                        Text(
                                          switchState.isSwitched
                                              ? 'on'.tr
                                              : 'off'.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30.0, left: 10),
                                      child: Switch(
                                        onChanged: (value) {
                                          setState(() {
                                            switchState.toggleSwitch();
                                            isSwitched = value;
                                            motorSwitch = DateTime.now();
                                          });
                                        },
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.white,
                                        inactiveTrackColor: Colors.red,
                                        inactiveThumbColor: Colors.white,
                                        value: switchState.isSwitched,
                                      ),
                                    ),
                                    SizedBox(width: 58),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40),
                                          child: Text(
                                            'last_on'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40),
                                          child: Text(
                                            '${DateFormat('jms').format(motorSwitch)} ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 180,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 70,
                                  width: 380,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 192, 27, 16),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'power_status'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                        ),
                                        Text(
                                          'on'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Image.asset("assets/power.png")),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'last_on'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '${DateFormat('jms').format(time)} ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 180,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 70,
                                  width: 380,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 192, 27, 16),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'motor_status'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                        ),
                                        Text(
                                          'on'.tr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            Image.asset("assets/motor.jpeg")),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'last_on'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '${DateFormat('jms').format(time)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          }
        });
  }
}

class SwitchState extends ChangeNotifier {
  bool isSwitched = false;

  void toggleSwitch() {
    isSwitched = !isSwitched;
    notifyListeners();
  }
}
