import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLanding extends StatefulWidget {
  final String id;
  const UserLanding({Key? key, required this.id}) : super(key: key);

  @override
  _UserLandingState createState() => _UserLandingState();
}

class _UserLandingState extends State<UserLanding> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http
        .get(Uri.parse("https://console-api.theja.in/device/getAll"), headers: {
      "Authorization": "Bearer $jwtToken",
    });

    if (response.statusCode == 200) {
      print('object');
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> devices =
          List<Map<String, dynamic>>.from(data);
      return devices;
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<Map<String, dynamic>> devices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Device List")),
      body: Center(
        child: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            final device = devices[index];
            return ListTile(
              title: Text(device['name']),
              subtitle: Text("Device ID: ${device['deviceId']}"),
              onTap: () {
                // Navigate to the homepage with the selected device ID
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         Homepage(deviceId: device['deviceId']),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
