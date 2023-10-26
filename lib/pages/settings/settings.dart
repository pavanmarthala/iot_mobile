// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Auth/singin.dart';
import 'Set_limits.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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

  void logout() async {
    // Clear user login details from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');

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
              backgroundColor: Colors.white,
              //  drawer: Drawer(),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Text(
                  "settings".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
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
// children: [
//               Text('User Name: ${userInfoData?["name"] ?? "Unknown"}'),
//               Text('Subscription Validity: ${userInfoData?["subscriptionValidity"] ?? "Unknown"}'),
//             ],
              body: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 60),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(100, 22, 44, 43),
                          backgroundImage: NetworkImage(
                              "https://p7.hiclipart.com/preview/782/114/405/5bbc3519d674c.jpg"),
                          // radius: 40,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                        ),
                        child: Text(
                          "welcome".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          "${userInfoData?["name"] ?? "Unknown"}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 222, 220, 220),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  'sub'.tr,
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 65,
                                ),
                                Text(
                                    '${userInfoData?["subscriptionValidity"] ?? "Unknown"}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))
                              ],
                            ),
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
                    trailing:
                        const Icon(Icons.notifications, color: Colors.black),
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
