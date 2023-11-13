// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../Auth/singin.dart';
import 'Set_limits.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notificationsEnabled = true; // Track notification status
  FirebaseApi firebaseApi = FirebaseApi();

  Widget customListTile({
    required String title,
    required IconData iconData,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
      trailing: Icon(
        iconData,
        size: 32,
      ),
    );
  }

  Future<void> toggleNotifications(bool enable) async {
    try {
      if (enable) {
        await firebaseApi.subscribeToTopic('Iot');
      } else {
        await firebaseApi.unsubscribeFromTopic('Iot');
        if (kDebugMode) {
          print('Unsubscribed from topic: Iot');
        }
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('notificationsEnabled', enable);
      // Update the notification status in shared preferences or perform any other necessary actions
    } catch (e) {
      print('Error toggling notifications: $e');
    }
  }

  // Future<void> toggleNotifications(bool enable) async {
  //   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //   if (enable) {
  //     // Subscribe to FCM topic
  //        subscribeToTopic('Iot');

  //     showToast(
  //       "Notifications Enabled ",
  //       position: StyledToastPosition.center,
  //       context: context,
  //       animation: StyledToastAnimation.scale,
  //       reverseAnimation: StyledToastAnimation.scale,
  //       duration: Duration(seconds: 4),
  //       animDuration: Duration(seconds: 1),
  //       curve: Curves.elasticOut,
  //       reverseCurve: Curves.linear,
  //       // backgroundColor: Colors.red,
  //       textStyle: TextStyle(color: Colors.white, fontSize: 16),
  //     );
  //   } else {
  //     // Unsubscribe from FCM topic
  //     await _firebaseMessaging.unsubscribeFromTopic('Iot');
  //     showToast(
  //       "Notifications Disabled",
  //       position: StyledToastPosition.center,
  //       context: context,
  //       animation: StyledToastAnimation.scale,
  //       reverseAnimation: StyledToastAnimation.scale,
  //       duration: Duration(seconds: 4),
  //       animDuration: Duration(seconds: 1),
  //       curve: Curves.elasticOut,
  //       reverseCurve: Curves.linear,
  //       // backgroundColor: Colors.red,
  //       textStyle: TextStyle(color: Colors.white, fontSize: 16),
  //     );
  //     print('disabled');
  //   }

  //   // Update the notification status in shared preferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('notificationsEnabled', enable);
  // }

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

  Future<Map<String, dynamic>>? userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = fetchUserInfo();
    loadNotificationStatus();
  }

  Future<void> loadNotificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? enabled = prefs.getBool('notificationsEnabled');
    if (enabled != null) {
      setState(() {
        notificationsEnabled = enabled;
      });
    }
  }

  Future<Map<String, dynamic>> fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs
        .getString('jwt_token'); // Retrieve the JWT token from local storage

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/user/getInfo'),
      headers: {"Authorization": "Bearer $jwtToken"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load user information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: userInfo,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          } else {
            final userInfoData = userSnapshot.data;
            return Scaffold(
              backgroundColor: const Color(0xffcbcbcb),

              //  drawer: Drawer(),
              // appBar: AppBar(
              //   iconTheme: IconThemeData(color: Colors.black),
              //   backgroundColor: Colors.white,
              //   title: Text(
              //     "settings".tr,
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black,
              //       fontSize: MediaQuery.of(context).size.width * 0.05,
              //     ),
              //   ),
              //   actions: [
              //     Padding(
              //       padding: EdgeInsets.only(right: 30),
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (context) => Langscreen(),
              //             ),
              //           );
              //         },
              //         child: CircleAvatar(
              //           radius: 18,
              //           backgroundColor: Colors.white,
              //           // backgroundImage: AssetImage('assets/language-icon.png'),
              //           child: SvgPicture.asset(
              //             'assets/language-icon.svg',
              //             // width: 100.0, // Adjust the width as needed
              //             // height: 100.0, // Adjust the height as needed
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
// children: [
//               Text('User Name: ${userInfoData?["name"] ?? "Unknown"}'),
//               Text('Subscription Validity: ${userInfoData?["subscriptionValidity"] ?? "Unknown"}'),
//             ],
              body: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08,
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Icon(
                        Icons.account_circle,
                        size: MediaQuery.of(context).size.width * 0.1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                        ),
                        child: Text(
                          "welcome".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          "${userInfoData?["name"] ?? "Unknown"}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        // top: 10,
                        // left: 14,
                        ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 7),
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Text(
                                "  " + 'sub'.tr,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(
                                  ': ${userInfoData?["subscriptionValidity"] ?? "Unknown"}',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.w500,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text('renew_sub'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20)),
                    trailing: const Icon(
                      Icons.refresh_outlined,
                      color: Colors.black,
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (userInfoData?["selectedDevice"] == null)
                    ListTile(
                      title: Text("set_limits".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                      trailing: const Icon(Icons.code, color: Colors.black),
                      onTap: () {
                        final selectedDevice =
                            userInfoData?["selectedDevice"] ?? "";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                Limits(selectedDevice: selectedDevice),
                          ),
                        );
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("notifications".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20)),
                    trailing: InkWell(
                      onTap: () {
                        setState(() {
                          notificationsEnabled = !notificationsEnabled;
                        });
                        toggleNotifications(notificationsEnabled);
                      },
                      child: Icon(
                        notificationsEnabled
                            ? Icons.notifications
                            : Icons.notifications_off,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text("sign_out".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20)),
                    trailing: const Icon(Icons.exit_to_app_outlined,
                        color: Colors.black),
                    onTap: () async {
                      logout();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
        });
  }
}
