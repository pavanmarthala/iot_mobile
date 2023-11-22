// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';

import 'newpassword.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController userInputController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;

  void _sendOtp() {
    // You can implement your own logic here to send OTP.
    // For this example, we'll just simulate that OTP is sent.
    setState(() {
      isOtpSent = true;
    });
  }

  void _verifyOtp() {
    // You can implement your own logic here to verify OTP.
    // For this example, we'll just simulate that OTP is verified.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('success'.tr),
        content: Text('otp_verified'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPasswordPage(),
                ),
              ); // Add your button's functionality here
            },
            child: Text('ok'.tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 227, 106),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'forgot-pass'.tr,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
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
                backgroundColor: const Color.fromARGB(255, 165, 227, 106),

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        //gradient: LinearGradient(
                        // colors: [Colors.white, Colors.green],
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
                        // ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'forgot-pass'.tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: userInputController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "enter_mobile/email".tr,
                                labelText: "mobile/email".tr),
                          ),
                          const SizedBox(height: 10.0),
                          if (isOtpSent)
                            TextFormField(
                              controller: otpController,
                              decoration: InputDecoration(
                                labelText: "enter_otp".tr,
                                hintText: "enter_otp".tr,
                              ),
                            ),
                          const SizedBox(height: 10.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: isOtpSent ? _verifyOtp : _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .green, // Change the button's background color
                                fixedSize: const Size(
                                    650, 50), // Increase the button's size
                              ),
                              child: Text(
                                  isOtpSent ? "verify_otp".tr : "send_otp".tr),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'go_to_signin'.tr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SingIN(),
                                    ),
                                  ); // Add your button's functionality here
                                },
                                child: Text(
                                  "click".tr,
                                  style: const TextStyle(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
