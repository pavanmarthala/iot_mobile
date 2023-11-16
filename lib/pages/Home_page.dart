// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';
// import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';
import 'package:iot_mobile_app/pages/tabs/Logs.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_mobile_app/providers/DeviceController.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'Drawer/Drawer.dart';
import 'lang_page.dart';

// import 'package:iot_console/pages/tabs/status.dart';

class Homepage extends StatefulWidget {
  final String deviceId;

  Homepage(
    this.deviceId,
  );

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
                        // width: 100.0, // Adjust the width as needed
                        // height: 100.0, // Adjust the height as needed
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: IconButton(
                //     onPressed: _handleMenuButtonPressed,
                //     icon: ValueListenableBuilder<AdvancedDrawerValue>(
                //       valueListenable: _advancedDrawerController,
                //       builder: (_, value, __) {
                //         return AnimatedSwitcher(
                //           duration: Duration(milliseconds: 250),
                //           child: Icon(
                //             value.visible ? Icons.clear : Icons.menu,
                //             key: ValueKey<bool>(value.visible),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20.0),
                //   child: CircleAvatar(
                //     radius: 16,
                //     backgroundColor: Colors.green,
                //     child: IconButton(
                //         onPressed: () {
                //           Navigator.of(context).push(
                //             MaterialPageRoute(
                //               builder: (context) => Settings(),
                //             ),
                //           );
                //         },
                //         icon: Icon(
                //           Icons.settings,
                //           size: 30,
                //           color: Colors.black,
                //         )),
                //   ),
                // ),
              ],
            ),
            body: screens[index],
            //  Stack(
            //   children: [
            //     Offstage(
            //       offstage: currentIndex != 0,
            //       child: Dash(widget.deviceId),
            //     ),
            //     Offstage(
            //       offstage: currentIndex != 1,
            //       child: Logs(),
            //     ),
            //   ],
            // ),
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
            )
            // SnakeNavigationBar.color(
            //   behaviour: SnakeBarBehaviour.floating,
            //   snakeShape: SnakeShape.circle,
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            //   padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            //   snakeViewColor: Colors.black,
            //   selectedItemColor: Colors.white,
            //   unselectedItemColor: Colors.black,
            //   showSelectedLabels: true,
            //   showUnselectedLabels: true,
            //   currentIndex: index,
            //   onTap: (index) => setState(() => this.index = index),
            //   items: [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.signal_cellular_alt_outlined),
            //       label: 'status'.tr,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.format_list_bulleted),
            //       label: 'logs'.tr,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.settings),
            //       label: 'settings'.tr,
            //     ),
            //   ],
            // ),

            ),
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
