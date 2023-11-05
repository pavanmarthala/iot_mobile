import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/animited_button.dart';
// import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/manage_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_devices.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/manage_user.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adminlandingpage extends StatefulWidget {
  const Adminlandingpage({Key? key}) : super(key: key);

  @override
  State<Adminlandingpage> createState() => _AdminlandingpageState();
}

class _AdminlandingpageState extends State<Adminlandingpage> {
  FirebaseApi firebaseApi = FirebaseApi();
  void logout() async {
    // Clear user login details from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('jwt_token');

    // Navigate back to the login page
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SingIN()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'manage_users'.tr,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
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
          Padding(
            padding: EdgeInsets.only(right: 20, left: 10),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green,
              child: IconButton(
                  onPressed: () async {
                    logout();
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.black,
                  )),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Users(),
                        ),
                      );

                      // Provide a valid function for the button
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'manage_users'.tr,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                ),

                // SizedBox(height: 10),

                Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Managedevice(),
                        ),
                      );

                      // Provide a valid function for the button
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'manage_devices'.tr,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                ),

                // SizedBox(height: 10),

                Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MapDevices(),
                        ),
                      );

                      // Provide a valid function for the button
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'map_a_device'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),

                // SizedBox(height: 10),

                Container(
                  width: 350,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Landingpage(id: ""),
                        ),
                      );

                      // Provide a valid function for the button
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'view_mapped_device'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ),

                Center(
                  child: AnimatedButton(
                      onTap: () {
                        // send notification from one device to another
                        firebaseApi.getDeviceToken().then((value) async {
                          var data = {
                            'to': value.toString(),
                            'notification': {
                              'title': 'pavan',
                              'body': 'Subscribe to my channel',
                            },
                            'android': {
                              'notification': {
                                'notification_count': 23,
                              },
                            },
                            'data': {'type': 'message', 'id': 'pavan'}
                          };

                          await http.post(
                              Uri.parse('https://fcm.googleapis.com/fcm/send'),
                              body: jsonEncode(data),
                              headers: {
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Authorization':
                                    'key=AAAALbfocX4:APA91bFVgtoqpq0gwRcp1016R45Pts1pQFFGWJzXozyEslix8VE1m1ZtyBCH7ueldVPeHvXqKTsGz9iTqHKE5hhsTZf9fUMeuA-3EAYl3Bqh9bW806x5AUN2B_9l1LrLWTrK5aUoVGia'
                              }
                              //     ).then((value) {
                              //   if (kDebugMode) {
                              //     print(value.body.toString());
                              //   }
                              // }).onError((error, stackTrace) {
                              //   if (kDebugMode) {
                              //     print(error);
                              //   }
                              // }
                              );
                        });
                      },
                      animationDuration: const Duration(milliseconds: 2000),
                      initialText: "Confirm",
                      finalText: "Submitted",
                      iconData: Icons.check,
                      iconSize: 32.0,
                      buttonStyle: buttonstyle(
                        primaryColor: Colors.green.shade600,
                        secondaryColor: Colors.white,
                        initialTextStyle: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                        finalTextStyle: TextStyle(
                          fontSize: 22.0,
                          color: Colors.green.shade600,
                        ),
                        elevation: 20.0,
                        borderRadius: 10.0,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
