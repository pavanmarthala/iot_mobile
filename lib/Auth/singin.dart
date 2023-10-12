// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/Home_page.dart';

import 'forgotpassword.dart';

class SingIN extends StatefulWidget {
  @override
  State<SingIN> createState() => _SingINState();
}

class _SingINState extends State<SingIN> {
  final formkey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                hintText: "enter_pin".tr, labelText: "pin".tr),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                             Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>Homepage(),
                                  ),
                                ); // Add your onPressed callback here
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors
                                  .green, // Change the button's background color
                              fixedSize:
                                  Size(650, 50), // Increase the button's size
                            ),
                            child: Text(
                              'sign_in'.tr,
                              style: TextStyle(
                                  fontSize: 20), // Customize the text size
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
                                onPressed: (
                                  
                              ) {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgotPasswordPage(),),);  // Add your button's functionality here
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
