import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectState extends StatefulWidget {
  const SelectState({Key? key}) : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
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
      // return an empty list
      return <String>[];
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/zone/state'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        // API response is a list of device names
        final deviceIds = jsonResponse
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

          return Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: Text(
                  'Select Device',
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
                ]),
            body: Center(
              child: ListView(children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: deviceIdsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                deviceIdsList[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          minWidth: 400, // Set the minimum width
                          height: 60,
                        ),
                        Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                      ],
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
