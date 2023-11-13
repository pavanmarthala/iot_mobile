import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/pages/settings/select_device.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Limits extends StatefulWidget {
  final String selectedDevice;

  const Limits({Key? key, required this.selectedDevice}) : super(key: key);

  @override
  _LimitsState createState() => _LimitsState();
}

class _LimitsState extends State<Limits> {
  final _minimumVoltageController = TextEditingController();
  final _maximumVoltageController = TextEditingController();
  final _minimumCurrentController = TextEditingController();
  final _maximumCurrentController = TextEditingController();
  // Future<Map<String, dynamic>>? deviceLimits;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDevice.isNotEmpty) {
      // Fetch and set device limits
      fetchDeviceLimits();
    }
  }

  Future<void> fetchDeviceLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return;
    }

    final response = await http.get(
      Uri.https(
          'console-api.theja.in', '/device/getLimits/${widget.selectedDevice}'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      _minimumVoltageController.text =
          (jsonResponse['minVoltage'] ?? '').toString();
      _maximumVoltageController.text =
          (jsonResponse['maxVoltage'] ?? '').toString();
      _minimumCurrentController.text =
          (jsonResponse['minCurrent'] ?? '').toString();
      _maximumCurrentController.text =
          (jsonResponse['maxCurrent'] ?? '').toString();
    } else {
      print('API Response (Error): ${response.body}');
      // Handle the error, e.g., display an error message
    }
  }

  Future<void> setMaximumCurrent(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return;
    }

    final response = await http.post(
      Uri.https('console-api.theja.in',
          '/device/maxCur/${widget.selectedDevice}/$value'),
      headers: {
        "Authorization": "Bearer $jwtToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // Value updated successfully
      print('Maximum current updated: $value');
    } else {
      print('Failed to update maximum current: ${response.body}');
      // Handle the error, e.g., display an error message
    }
  }

  Future<void> setMinimumCurrent(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return;
    }

    final response = await http.post(
      Uri.https('console-api.theja.in',
          '/device/minCur/${widget.selectedDevice}/$value'),
      headers: {
        "Authorization": "Bearer $jwtToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // Value updated successfully
      print('Minimum current updated: $value');
    } else {
      print('Failed to update minimum current: ${response.body}');
      // Handle the error, e.g., display an error message
    }
  }

  Future<void> setMaximumVoltage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return;
    }

    final response = await http.post(
      Uri.https('console-api.theja.in',
          '/device/maxVol/${widget.selectedDevice}/$value'),
      headers: {
        "Authorization": "Bearer $jwtToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // Value updated successfully
      print('Maximum voltage updated: $value');
    } else {
      print('Failed to update maximum voltage: ${response.body}');
      // Handle the error, e.g., display an error message
    }
  }

  Future<void> setMinimumVoltage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return;
    }

    final response = await http.post(
      Uri.https('console-api.theja.in',
          '/device/minVol/${widget.selectedDevice}/$value'),
      headers: {
        "Authorization": "Bearer $jwtToken",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // Value updated successfully
      print('Minimum voltage updated: $value');
    } else {
      print('Failed to update minimum voltage: ${response.body}');
      // Handle the error, e.g., display an error message
    }
  }

  Future<void> saveLimits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      return;
    }

    final Map<String, dynamic> requestPayload = {
      "deviceId": widget.selectedDevice,
      "minVoltage": _minimumVoltageController.text,
      "maxVoltage": _maximumVoltageController.text,
      "minCurrent": _minimumCurrentController.text,
      "maxCurrent": _maximumCurrentController.text,
    };

    final response = await http.post(
      Uri.https('console-api.theja.in', '/device/setLimits'),
      headers: {
        "Authorization": "Bearer $jwtToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestPayload),
    );

    if (response.statusCode == 200) {
      // Limits saved successfully
      // You can handle the success case here
      print('Limits saved successfully');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Settings(), // Replace with the correct settings page
        ),
      );
    } else {
      print('Failed to save limits: ${response.body}');
      // Handle the error case here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          // Container(
          //   width: double.infinity,
          //   // padding: EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Navigator.of(context).push(
          //       //   MaterialPageRoute(
          //       //     builder: (context) => Settings(),
          //       //   ),
          //       // );
          //       saveLimits();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.green,
          //       padding: EdgeInsets.symmetric(vertical: 20),
          //     ),
          //     child: Text('save_device_list'.tr, style: TextStyle(fontSize: 20)),
          //   ),
          // ),
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedButton(
                onTap: () {
                  saveLimits();

                  // print("animated button pressed");
                },
                animationDuration: const Duration(milliseconds: 2000),
                initialText: 'save_device_list'.tr,
                finalText: "device_limits_saved".tr,
                iconData: Icons.check,
                iconSize: 32.0,
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
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "set_limits".tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
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
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/language-icon.svg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'device'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectDevice(),
                    ),
                  );
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'Select Device'.tr,
                ),
                controller: TextEditingController(text: widget.selectedDevice),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'minimum_voltage'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _minimumVoltageController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_minimum_voltage'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'maximum_voltage'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _maximumVoltageController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_maximum_voltage'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'minimum_current'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _minimumCurrentController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_minimum_current'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'maximum_current'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _maximumCurrentController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_maximum_current'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
