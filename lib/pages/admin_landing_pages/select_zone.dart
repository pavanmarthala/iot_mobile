import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectZone extends StatefulWidget {
  final String selectedState;
  final String selectedDistrict;

  SelectZone(this.selectedState, this.selectedDistrict);

  @override
  _SelectZoneState createState() => _SelectZoneState();
}

class _SelectZoneState extends State<SelectZone> {
  Future<List<String>>? zoneNames;

  @override
  void initState() {
    super.initState();
    zoneNames = fetchZones(widget.selectedState, widget.selectedDistrict);
  }

  Future<List<String>> fetchZones(
      String selectedState, String selectedDistrict) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return <String>[];
    }

    final response = await http.get(
      Uri.https('console-api.theja.in',
          '/zone/zone/$selectedState/$selectedDistrict'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        final zoneList =
            jsonResponse.map((zoneJson) => zoneJson.toString()).toList();
        return zoneList;
      } else {
        return <String>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load zone names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Zone'),
      ),
      body: FutureBuilder<List<String>>(
        future: zoneNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final zoneList = snapshot.data;

            if (zoneList == null || zoneList.isEmpty) {
              return Center(child: Text('No zone names found.'));
            }

            return ListView.builder(
              itemCount: zoneList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, zoneList[index]);
                  },
                  title: Text(zoneList[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
