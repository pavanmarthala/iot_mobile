import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => UserPage(),
        '/deviceIds': (context) => DeviceIdsPage(),
      },
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
      ),
      body: UserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/deviceIds');
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class DeviceIdsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device IDs'),
      ),
      body: DeviceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<Map<String, dynamic>>? userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = fetchUserInfo();
  }

  Future<Map<String, dynamic>> fetchUserInfo() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? jwtToken = prefs.getString('jwt_token'); // Retrieve the JWT token from local storage

    // if (jwtToken == null) {
    //   // Handle the case where the token is not found
    //   // return null;
    // }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/admin/getAllDeviceIds'),
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI5Njc2MzE2MTY0IiwiYXV0aG9yaXRpZXMiOlsiYWRtaW4iXSwidWlkIjo5NzU1LCJpYXQiOjE2OTc1NDM4MjksImV4cCI6MTcyOTA3OTgyOX0.lJnSjgl1-ZeyYjHniPkNhijiz7PMRgc98yBJOzF7baHB3vzWJmB4AGIw8DQXOmO6-zsy-dY47j96lnrKSq5bBw"
      },
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

          return Column(
            children: [
              Text('User Name: ${userInfoData?["name"] ?? "Unknown"}'),
              Text('Subscription Validity: ${userInfoData?["subscriptionValidity"] ?? "Unknown"}'),
            ],
          );
        }
      },
    );
  }
}
class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  Future<List<String>>? deviceIds;

  @override
  void initState() {
    super.initState();
    deviceIds = fetchDeviceIds();
  }

 Future<List<String>> fetchDeviceIds() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jwtToken = prefs.getString('jwt_token'); // Retrieve the JWT token from local storage

  if (jwtToken == null) {
    // Handle the case where the token is not found
    // return null;
  }
  final response = await http.get(
    Uri.https('console-api.theja.in', '/user/getInfo'), // Use the correct endpoint
    headers: {
      "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI5Njc2MzE2MTY0IiwiYXV0aG9yaXRpZXMiOlsiYWRtaW4iXSwidWlkIjo5NzU1LCJpYXQiOjE2OTc1NDM4MjksImV4cCI6MTcyOTA3OTgyOX0.lJnSjgl1-ZeyYjHniPkNhijiz7PMRgc98yBJOzF7baHB3vzWJmB4AGIw8DQXOmO6-zsy-dY47j96lnrKSq5bBw",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> deviceIdsJson = jsonResponse["deviceIds"];


    if (deviceIdsJson is List) {
      final deviceIds = deviceIdsJson.map((deviceIdJson) => deviceIdJson.toString()).toList();
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

          return Center(
            child: SizedBox(
              child: ListView.builder(
                itemCount: deviceIdsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title:  SingleChildScrollView(
                      child: Column(
                        children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle button press for each device
                                  // You can navigate to a specific page or perform other actions here
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      deviceIdsList[index],
                                      style: TextStyle(
                                        color: const Color.fromARGB(255, 195, 51, 41),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(223, 240, 200, 200),
                                  fixedSize: Size(770, 60),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 218, 117, 110),
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
                    )
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
