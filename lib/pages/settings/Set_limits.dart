import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
  Future<Map<String, dynamic>>? deviceLimits;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDevice.isNotEmpty) {
      deviceLimits = fetchDeviceLimits(widget.selectedDevice);
      deviceLimits?.then((limits) {
        if (limits != null) {
          _minimumVoltageController.text =
              (limits['minVoltage'] ?? '').toString();
          _maximumVoltageController.text =
              (limits['maxVoltage'] ?? '').toString();
          _minimumCurrentController.text =
              (limits['minCurrent'] ?? '').toString();
          _maximumCurrentController.text =
              (limits['maxCurrent'] ?? '').toString();
        }
      }).catchError((error) {
        // Handle the error here
        print("Failed to load device limits: $error");
      });
    }
  }

  Future<Map<String, dynamic>> fetchDeviceLimits(String deviceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return {};
    }

    final response = await http.get(
      Uri.https('console-api.theja.in', '/device/getLimits/$deviceId'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      print("Device Limits: $jsonResponse"); // Add this line
      return jsonResponse;
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load device limits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Settings(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('save_device_list'.tr, style: TextStyle(fontSize: 20)),
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
                  hintText: 'Select Device'.tr,
                ),
                controller: TextEditingController(text: widget.selectedDevice),
              ),
              Container(
                height: 1,
                color: Colors.grey,
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
