// ignore_for_file: unnecessary_type_check

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'labels.dart/load.dart';
import 'labels.dart/motor.dart';
import 'labels.dart/power.dart';

class Logs extends StatefulWidget {
  final String deviceId;

  Logs(this.deviceId, {super.key});

  @override
  State<Logs> createState() => _LogsState(deviceId);
}

class _LogsState extends State<Logs> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late DateTime _dateTime;
  late String _formattedDate; // Remove the initializer here

  final String deviceId;
  Future<List<String>>? deviceIds;
  Future<Map<String, dynamic>>? logsData;

  _LogsState(this.deviceId) {
    // Move the initialization to the constructor
    _dateTime = DateTime.now();
    _formattedDate = DateFormat('yyyy-MM-dd').format(_dateTime);
  }
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    deviceIds = fetchDeviceIds();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        final formattedDate = DateFormat('yyyy-MM-dd').format(value);

        setState(() {
          _dateTime = value;
          _formattedDate = formattedDate;
        });
      }
    });
  }

  Future<List<String>> fetchDeviceIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      throw Exception('JWT Token not found');
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
      print(jsonResponse);
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

  Future<Map<String, dynamic>> fetchLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      throw Exception('JWT Token not found');
    }

    final url =
        Uri.https('console-api.theja.in', '/getLogs/$deviceId/$_formattedDate');

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    }
    {
      print('API Response (Error): ${response.body}');
      // Return an empty map or a specific error message to indicate an error
      return {"error": "Failed to load logs"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: deviceIds,
        builder: (context, deviceIdsSnapshot) {
          if (deviceIdsSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (deviceIdsSnapshot.hasError) {
            return Center(child: Text('Error: ${deviceIdsSnapshot.error}'));
          } else {
            final deviceIdsList = deviceIdsSnapshot.data;

            if (deviceIdsList == null || deviceIdsList.isEmpty) {
              return Center(child: Text('No device IDs found.'));
            }

            return FutureBuilder<Map<String, dynamic>>(
                future: fetchLogs(),
                builder: (context, logsSnapshot) {
                  if (logsSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (logsSnapshot.hasError) {
                    return Center(child: Text('Error: ${logsSnapshot.error}'));
                  } else {
                    final logData = logsSnapshot.data;

                    if (logData == null) {
                      return Center(child: Text('No logs found.'));
                    }

                    final powerLogs = logData["powerLogsDto"];
                    final motorLogs = logData["motorLogsDto"];
                    final loadLogs = logData["loadLogsDto"];

                    return Container(
                        color: Color.fromARGB(255, 247, 242, 242),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 45),
                              child: Row(
                                children: [
                                  Text(
                                    'device_no:1'.tr,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${widget.deviceId}',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 0),
                              child: Row(
                                children: [
                                  Text(
                                    'log_date'.tr,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 100),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextButton(
                                      onPressed: _showDatePicker,
                                      child: Text(
                                        _formattedDate,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 180, 179, 179),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: TabBar(
                                        unselectedLabelColor: Colors.black,
                                        labelColor: Colors.white,
                                        indicatorColor: Colors.black38,
                                        indicator: BoxDecoration(
                                          color:
                                              Color.fromARGB(181, 51, 42, 55),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        controller: tabController,
                                        tabs: [
                                          Tab(
                                              child: Text('power'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          Tab(
                                              child: Text('motor'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                          Tab(
                                              child: Text('load'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  Power(powerLogs),
                                  Motor(motorLogs),
                                  Load(loadLogs),
                                ],
                              ),
                            ),
                          ],
                        ));
                  }
                });
          }
        });
  }
}
