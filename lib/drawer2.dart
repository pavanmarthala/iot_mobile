// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              'data',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      drawer: SafeArea(child: MyDrawer()
          // Container(
          //   child: ListTileTheme(
          //     textColor: Colors.white,
          //     iconColor: Colors.white,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Container(
          //           width: 128.0,
          //           height: 128.0,
          //           margin: const EdgeInsets.only(
          //             top: 24.0,
          //             bottom: 64.0,
          //           ),
          //           clipBehavior: Clip.antiAlias,
          //           decoration: BoxDecoration(
          //             color: Colors.black26,
          //             shape: BoxShape.circle,
          //           ),
          //           child: Image.asset(
          //             'assets/power.png',
          //           ),
          //         ),
          //         ListTile(
          //           onTap: () {
          //             Navigator.of(context).push(
          //               MaterialPageRoute(
          //                 builder: (context) => HomeScreen(),
          //               ),
          //             );
          //           },
          //           leading: Icon(Icons.home),
          //           title: Text('Home'),
          //         ),
          //         ListTile(
          //           onTap: () {},
          //           leading: Icon(Icons.account_circle_rounded),
          //           title: Text('Profile'),
          //         ),
          //         ListTile(
          //           onTap: () {},
          //           leading: Icon(Icons.favorite),
          //           title: Text('Favourites'),
          //         ),
          //         ListTile(
          //           onTap: () {},
          //           leading: Icon(Icons.settings),
          //           title: Text('Settings'),
          //         ),
          //         Spacer(),
          //         DefaultTextStyle(
          //           style: TextStyle(
          //             fontSize: 12,
          //             color: Colors.white54,
          //           ),
          //           child: Container(
          //             margin: const EdgeInsets.symmetric(
          //               vertical: 16.0,
          //             ),
          //             child: Text('Terms of Service | Privacy Policy'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class Drawer2 extends StatefulWidget {
  const Drawer2({Key? key}) : super(key: key);

  @override
  _Drawer2State createState() => _Drawer2State();
}

class _Drawer2State extends State<Drawer2> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            'data',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Widget> buttons = [];

  Future<List<String>>? deviceIds;

  @override
  void initState() {
    super.initState();
    deviceIds = fetchDeviceIds();
  }

  Future<List<String>> fetchDeviceIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/user/getInfo'),
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

          return Container(
            child: Center(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/logo.png"),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: deviceIdsList.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 5, top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                                //
                                // Handle button press for each device
                                // You can navigate to a specific page or perform other actions here
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'device_no:1'.tr,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 16, 16, 16),
                                    ),
                                  ),
                                  Text(
                                    deviceIdsList[index],
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(223, 248, 248, 248),
                                fixedSize: Size(770, 60),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 251, 250, 250),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]),
            ),
          );
        }
      },
    );
  }
}
