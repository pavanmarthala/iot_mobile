import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/Add_user.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/add_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/edit.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_device.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredDeviceList = [];
  List<Map<String, String>> deviceList = [];

  Future<List<Map<String, String>>>? devices;

  @override
  void initState() {
    super.initState();
    devices = fetchDevices();
  }

  Future<List<Map<String, String>>> fetchDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/admin/getAllUsers'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        deviceList = jsonResponse.map((device) {
          return {
            "mobile": device["mobile"].toString(),
            "name": device['userDetails']['name'].toString(),
            "active": device["active"].toString(),
          };
        }).toList();

        filterDevices(''); // Initialize with an empty query
        return deviceList;
      } else {
        return <Map<String, String>>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load devices');
    }
  }

  void filterDevices(String query) {
    setState(() {
      filteredDeviceList = deviceList
          .where((device) =>
              (device["name"] ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (device["mobile"] ?? "")
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffcbcbcb),
        appBar: AppBar(
          title: const Text("Manage Users"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Langscreen(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green,
                  child: SvgPicture.asset('assets/language-icon.svg'),
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Map<String, String>>>(
          future: devices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: [
                            const Text("Users",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                // controller: searchController,
                                onChanged: (value) {
                                  filterDevices(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  // hintText: 'Search for users',
                                  hintText: 'search for users',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(),
                                  ),
                                  fillColor:
                                      const Color.fromARGB(255, 248, 245, 245),
                                  filled: true,
                                  suffixIcon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 650,
                      child: Expanded(
                        child: ListView(
                          children: filteredDeviceList.map((device) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20),
                                      child: Text(
                                        device["name"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20),
                                      child: Text(
                                        device["mobile"] ?? "",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 10),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserDetailsScreen(
                                                    mobileId:
                                                        device["mobile"] ?? "",
                                                    deviceIdId: '',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'View',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      234, 42, 228, 138),
                                              fixedSize: const Size(120, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        234, 239, 9, 9),
                                                onPrimary: Colors.black,
                                                fixedSize: const Size(120, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                  device["active"] == "true"
                                                      ? 'Deactivate'
                                                      : 'Activate',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: device[
                                                              "active"] ==
                                                          "true"
                                                      ? const Color.fromARGB(
                                                          234, 42, 228, 138)
                                                      : const Color.fromARGB(
                                                          234, 239, 9, 9),

                                                  // Green
                                                  onPrimary: Colors.black,
                                                  fixedSize:
                                                      const Size(120, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            decoration: const BoxDecoration(
                // color: Colors.white,
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
                              builder: (context) => const Adminlandingpage(),
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
                                builder: (context) => const Adduser(),
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
                                builder: (context) => const Mapdevice(),
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
