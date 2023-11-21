// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';
import 'package:iot_mobile_app/pages/tabs/Logs.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Drawer/Drawer.dart';
import 'lang_page.dart';

// import 'package:iot_console/pages/tabs/status.dart';

class Homepage extends StatefulWidget {
  final String deviceId;

  Homepage(this.deviceId, {super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// final drawercontroller = AdvancedDrawerController();

class _HomepageState extends State<Homepage> {
  // @override
  // void dispose() {
  //   super.dispose();

  //   // Trigger the refresh callback when the Homepage is disposed (popped from the navigator stack)
  //   Landingpage.landingpageKey.currentState?.refreshData();
  // }

  FirebaseApi firebaseApi = FirebaseApi();
  int index = 0;
  List<Widget> screens = []; // Initialize the screens list

  @override
  void initState() {
    super.initState();
    screens = [
      Dash(widget.deviceId), // You can pass widget.deviceId here
      Logs(widget.deviceId),
      Settings(),
    ];
  }

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  final _advancedDrawerController = AdvancedDrawerController();

  Map<String, dynamic> decodeJwt(String token) {
    try {
      return JwtDecoder.decode(token);
    } catch (e) {
      print('Error decoding JWT: $e');
      return {};
    }
  }

  Future<bool> checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken != null) {
      Map<String, dynamic> decodedToken = decodeJwt(jwtToken);
      List<dynamic> authorities = decodedToken['authorities'];

      return authorities.contains('admin') ||
          authorities.contains('superAdmin');
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final selectedDeviceId = deviceController.selectedDeviceId;
    return WillPopScope(
      onWillPop: () async {
        // Signal the refresh to the Landingpage when navigating back
        Navigator.pop(context, true);
        return true;
      },
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.withOpacity(0.2),
                Colors.blueGrey,
              ],
            ),
          ),
        ),
        controller: _advancedDrawerController,
        // rtlOpening: true,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        animateChildDecoration: true,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Scaffold(
            backgroundColor: const Color(0xffcbcbcb),
            // drawer: MyDrawer(),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "dashboard".tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Colors.black),
              ),
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
                //   onPressed: () {
                //     // Navigator.pushNamed(context, '/user_landing');

                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => Landingpage(id: ''),
                //       ),
                //     );
                //   },
                //   icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                FutureBuilder<bool>(
                  future: checkUserRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Adminlandingpage(),
                                  ),
                                );
                              },
                              child: Icon(Icons.home_outlined)),
                        );
                      }
                    }
                    return Container(); // Return an empty container if not admin or superadmin
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: screens[index],
            bottomNavigationBar: MoltenBottomNavigationBar(
              // margin: EdgeInsets.all(10),
              // borderRaduis: BorderRadius.circular(15),
              barHeight: 60,
              domeHeight: 10,
              curve: Curves.easeInBack,
              domeCircleSize: 40,
              selectedIndex: index,
              onTabChange: (int newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
              tabs: [
                MoltenTab(
                  icon: Icon(Icons.signal_cellular_alt_outlined),
                  title: Text(
                    'status'.tr,
                  ),
                  selectedColor: Colors.white,
                ),
                MoltenTab(
                  icon: Icon(Icons.format_list_bulleted),
                  title: Text(
                    'logs'.tr,
                  ),
                  selectedColor: Colors.white,
                ),
                MoltenTab(
                  icon: Icon(Icons.settings),
                  title: Text(
                    'settings'.tr,
                  ),
                  selectedColor: Colors.white,
                ),
              ],
            )),
        drawer: SafeArea(child: MyDrawer()),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
