// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'forgotpassword.dart';

class SingIN extends StatefulWidget {
  const SingIN({super.key});

  @override
  State<SingIN> createState() => _SingINState();
}

class _SingINState extends State<SingIN> {
  final formkey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  void login(String user, password) async {
    final Map<String, dynamic> requestData = {
      "pin": password,
      "userId": user,
    };

    try {
      final response = await http.post(
        Uri.parse('https://console-api.theja.in/login'),
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        if (kDebugMode) {
          print(data);

          print('account login sucessfully');

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          ); // Add your button's functionality here
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 165, 227, 106),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'sign_in'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
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
                backgroundColor: Color.fromARGB(255, 165, 227, 106),

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/loginbg.jpg",
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Center(
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'log_in_to_console'.tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "mobile/email".tr,
                                  labelText: "enter_mobile/email".tr),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "enter_pin".tr,
                                  labelText: "pin".tr),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                login(_usernameController.text.toString(),
                                    _passwordController.text.toString());
                              },
                              child: Container(
                                height: 50,
                                width: 650,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'sign_in'.tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'forgot_password'.tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage(),
                                      ),
                                    ); // Add your button's functionality here
                                  },
                                  child: Text(
                                    "click".tr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      // Change the text color as needed
                                      fontSize:
                                          16, // Adjust the text size as needed
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
