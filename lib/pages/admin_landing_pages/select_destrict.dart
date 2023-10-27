import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDistrict extends StatefulWidget {
  final String selectedState;

  SelectDistrict(this.selectedState);

  @override
  _SelectDistrictState createState() => _SelectDistrictState();
}

class _SelectDistrictState extends State<SelectDistrict> {
  Future<List<String>>? districtNames;

  @override
  void initState() {
    super.initState();
    districtNames = fetchDistricts(widget.selectedState);
  }

  Future<List<String>> fetchDistricts(String selectedState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      return <String>[];
    }

    final response = await http.get(
      Uri.https('console-api.theja.in', '/zone/dist/$selectedState'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        final districtList = jsonResponse
            .map((districtJson) => districtJson.toString())
            .toList();
        return districtList;
      } else {
        return <String>[];
      }
    } else {
      print('API Response (Error): ${response.body}');
      throw Exception('Failed to load district names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select District'),
      ),
      body: FutureBuilder<List<String>>(
        future: districtNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final districtList = snapshot.data;

            if (districtList == null || districtList.isEmpty) {
              return Center(child: Text('No district names found.'));
            }

            return ListView.builder(
              itemCount: districtList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, districtList[index]);
                  },
                  title: Text(districtList[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
