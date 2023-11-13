// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mapdevice extends StatefulWidget {
  const Mapdevice({super.key});

  @override
  State<Mapdevice> createState() => _LimitsState();
}

class _LimitsState extends State<Mapdevice> {
  final _userController = TextEditingController();
  final _deviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          //BottomAppBar(
          // Container(
          //   width: double.infinity,
          //   // padding: EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       String userId = _userController.text;
          //       String deviceId = _deviceController.text;

          //       // Get the JWT token from SharedPreferences
          //       SharedPreferences prefs = await SharedPreferences.getInstance();
          //       String? jwtToken = prefs.getString('jwt_token');

          //       if (jwtToken == null) {
          //         // Handle the case where the token is missing
          //         return;
          //       }

          //       // Prepare the headers with the JWT token
          //       Map<String, String> headers = {
          //         'Authorization': 'Bearer $jwtToken',
          //         "Content-Type": "application/json",
          //       };

          //       // Make the API POST request with headers
          //       Uri apiUrl = Uri.parse(
          //           'https://console-api.theja.in/admin/mapDevice/$deviceId/$userId');
          //       http.post(apiUrl, headers: headers).then((response) {
          //         if (response.statusCode == 200) {
          //           // Request was successful
          //           print('API request successful');
          //           // You can add further actions here if needed
          //         } else {
          //           // Request failed
          //           print(
          //               'API request failed with status code: ${response.statusCode}');
          //           print('Response body: ${response.body}');
          //           // You can handle the error here
          //         }
          //       }).catchError((error) {
          //         // Request failed
          //         print('API request failed with error: $error');
          //         // You can handle the error here
          //       });
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: Colors.green,
          //       padding: EdgeInsets.symmetric(vertical: 20),
          //     ),
          //     child: Text('map_user_to_device'.tr, style: TextStyle(fontSize: 20)),
          //   ),
          // ),
          // ),

          BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                  onTap: () async {
                    String userId = _userController.text;
                    String deviceId = _deviceController.text;

                    // Get the JWT token from SharedPreferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? jwtToken = prefs.getString('jwt_token');

                    if (jwtToken == null) {
                      // Handle the case where the token is missing
                      return;
                    }

                    // Prepare the headers with the JWT token
                    Map<String, String> headers = {
                      'Authorization': 'Bearer $jwtToken',
                      "Content-Type": "application/json",
                    };

                    // Make the API POST request with headers
                    Uri apiUrl = Uri.parse(
                        'https://console-api.theja.in/admin/mapDevice/$deviceId/$userId');
                    http.post(apiUrl, headers: headers).then((response) {
                      if (response.statusCode == 200) {
                        // Request was successful
                        print('API request successful');
                        // You can add further actions here if needed
                      } else {
                        // Request failed
                        print(
                            'API request failed with status code: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        // You can handle the error here
                      }
                    }).catchError((error) {
                      // Request failed
                      print('API request failed with error: $error');
                      // You can handle the error here
                    });
                  },
                  animationDuration: const Duration(milliseconds: 2000),
                  initialText: 'map_user_to_device'.tr,
                  finalText: "Mapped successful",
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
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "map_user_to_device".tr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.05),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'user_id'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_user_id'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'device_id'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              TextField(
                controller: _deviceController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_id'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
