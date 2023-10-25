import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/Add_user.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/add_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_device.dart';

import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
// import 'package:rive/rive.dart';

class Mapdevices extends StatefulWidget {
  const Mapdevices({super.key});

  @override
  State<Mapdevices> createState() => _MapdevicesState();
}

class _MapdevicesState extends State<Mapdevices> {
  @override
  Widget build(BuildContext context) {
    // Calculate the button width based on the screen width

    // final screenWidth = MediaQuery.of(context).size.width;

    // final buttonWidth = screenWidth / 4;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.green,
          title: const Text(
            'Map User And Device ',
            style: TextStyle(color: Colors.black, fontSize: 22),
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
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // User container with search box

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        borderRadius:
                            BorderRadius.circular(20), // Rounded border
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // User container text

                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'User ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),

                              // Search box

                              Container(
                                height: 32,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: 230, // Adjust the width as needed
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      fillColor: const Color.fromARGB(
                                          255, 251, 247, 247),
                                      filled: true,
                                      // hintText: 'search for devices',
                                      suffixIcon: const Icon(Icons.search)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            width: 290,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              'Selected user',
                              style: TextStyle(fontSize: 20),
                            )),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Device container

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,

                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded border
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // User container text

                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Device ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),

                              // Search box

                              Container(
                                height: 32,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),

                                width: 230, // Adjust the width as needed

                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none),
                                      fillColor: const Color.fromARGB(
                                          255, 246, 242, 242),
                                      filled: true,
                                      // hintText: 'search for devices',
                                      suffixIcon: const Icon(Icons.search)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            width: 290,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              'Selected Device',
                              style: TextStyle(fontSize: 20),
                            )),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // Save button

                    ElevatedButton(
                      onPressed: () {
                        // Save user and device selection
                      },
                      child: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor:
                            const Color.fromARGB(234, 42, 228, 138),
                        fixedSize: const Size(220, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.green,

                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded border
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Adminlandingpage(),
                            ),
                          );

                          // Go back to Home Screen
                        },
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 85,
                        decoration: BoxDecoration(
                          color: Colors.green,

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Adduser(),
                              ),
                            );

                            // Go back to Home Screen
                          },
                          child: const Text(
                            'ADD User',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.green,

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddDevice(),
                              ),
                            );

                            // Go back to Home Screen
                          },
                          child: const Text(
                            'Add Device',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.green,

                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded border
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Mapdevice(),
                              ),
                            );

                            // Go back to Home Screen
                          },
                          child: const Text(
                            'Map Device',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
