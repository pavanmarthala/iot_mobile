import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final _deviceController = TextEditingController();
  final _devicenameController = TextEditingController();
  final _pinController = TextEditingController();
  final _simController = TextEditingController();
  final _topiccontroller = TextEditingController();
  final _zonecontroller = TextEditingController();
  final _serialNocontroller = TextEditingController();
  final _mobileNocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          // BottomAppBar(
          // Container(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       final jsonData = {
          //         "active": true,
          //         "deviceId": _deviceController.text,
          //         "deviceSerialNumber": _serialNocontroller.text,
          //         "name": _devicenameController.text,
          //         "simId": _simController.text,
          //         "topic": _topiccontroller.text,
          //         "zone": _zonecontroller.text,
          //       };
          //       final jsonString = json.encode(jsonData);
          //       SharedPreferences prefs = await SharedPreferences.getInstance();
          //       String? jwtToken = prefs.getString('jwt_token');
          //       if (jwtToken == null) {
          //       }
          //       final response = await http.post(
          //           Uri.https('console-api.theja.in', '/admin/addDevice'),
          //           headers: {
          //             "Authorization": "Bearer $jwtToken",
          //             "Content-Type": "application/json",
          //           },
          //           body: jsonString);

          //       if (response.statusCode == 200) {
          //         // Successful response, you can handle it as per your requirement.
          //         print("Device added successfully");
          //         print("Response Body: ${response.body}");
          //       } else {
          //         // Error response, display an error message or handle it as needed.
          //         print(
          //             "Failed to add device. Status Code: ${response.statusCode}");
          //         print("Response Body: ${response.body}");
          //       }
          //       Navigator.of(context).pop();

          //       // Close the dialog after handling the response.
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.green,
          //       padding: EdgeInsets.symmetric(vertical: 20),
          //     ),
          //     child: Text('add_device'.tr, style: TextStyle(fontSize: 20)),
          //   ),
          // )),
          BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                  onTap: () async {
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

                    // final headers = {"Authorization": "Bearer "};

                    // final response =
                    //     await http.post(url, headers: headers, );

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? jwtToken = prefs.getString('jwt_token');

                    if (jwtToken == null) {
                      // Handle the case where the token is not found
                      // return null;
                    }
                    final response = await http.post(
                        Uri.https('console-api.theja.in', '/admin/addDevice'),
                        headers: {
                          "Authorization": "Bearer $jwtToken",
                          "Content-Type": "application/json",
                        },
                        body: jsonString);

                    if (response.statusCode == 200) {
                      // Successful response, you can handle it as per your requirement.
                      print("Device added successfully");
                      print("Response Body: ${response.body}");
                    } else {
                      // Error response, display an error message or handle it as needed.
                      print(
                          "Failed to add device. Status Code: ${response.statusCode}");
                      print("Response Body: ${response.body}");
                    }
                    // Navigator.of(context).pop();

                    // Close the dialog after handling the response.
                  },
                  animationDuration: const Duration(milliseconds: 2000),
                  initialText: 'add_device'.tr,
                  finalText: "Device Added",
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
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.green.shade600,
                    ),
                    elevation: 20.0,
                    borderRadius: 10.0,
                  )),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'add_device'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('device_id'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _deviceController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_id'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('device_name'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _devicenameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_name'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('pin'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _pinController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_pin'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('sim'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _simController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_sim'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('topic'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _topiccontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_topic'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('zone'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _zonecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_zone'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('device_serial-no'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _serialNocontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_serial_no'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text('mobile_number'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  )),
              TextField(
                controller: _mobileNocontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_mobile_number'.tr,
                ),
              ),
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
