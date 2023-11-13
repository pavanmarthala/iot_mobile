// ignore_for_file: prefer_const_constructors, dead_code, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
// import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Define the decodeToken method to decode the JWT token
  Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }
    final payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    final Map<String, dynamic> map = json.decode(resp);
    return map;
  }

  FirebaseApi firebaseApi = FirebaseApi();
  @override
  void initState() {
    super.initState();
    firebaseApi.initNotifications();
    firebaseApi.isTokenRefresh();
    firebaseApi.firebaseInit(context);
    firebaseApi.setupInteractMessage(context);
    firebaseApi.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });

    _navigateToPage();
  }

  void _navigateToPage() async {
    // Simulate checking the user's login status.
    await Future.delayed(Duration(seconds: 2));

    // Fetch the stored JWT token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');
    String? userId = prefs.getString('username');
    print('JWT Token: $jwtToken');
    print('User ID: $userId');
    if (jwtToken == null) {
      // If the token is not found, go to the login page.
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SingIN()));
    } else {
      // Decode the JWT token
      Map<String, dynamic> decodedToken = decodeToken(jwtToken);

      // Check user role
      List<dynamic> authorities = decodedToken['authorities'];
      if (authorities.contains('admin') || authorities.contains('superAdmin')) {
        // User is a superadmin, navigate to AdminLandingPage.
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Adminlandingpage()),
          (route) => false,
        );
      } else {
        // User is not a superadmin, navigate to the user landing page.
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Landingpage(id: userId ?? "")),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_theja.png'),
      ),
    );
  }
}
