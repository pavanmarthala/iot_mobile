// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, use_key_in_widget_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/newpassword.dart';
import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController userInputController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSent = false;
  String userId = "";
  Timer? _resendTimer;
  int _remainingTime = 30; // 30 seconds

  Future<void> _sendOtp(String userPhNumber) async {
    // You can implement your own logic here to send OTP.
    // For this example, we'll just simulate that OTP is sent.

    try {
      final response = await http.post(
        Uri.parse('http://console-api.theja.in/sendOtp/$userPhNumber'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        setState(() {
          isOtpSent = true;
          userId = userPhNumber; // Store the user's ID
        });
        print("OPT sent");
        //   isOtpSent = true;
        setState(() {
          isOtpSent = true;
        });
        print("OTP staus:  $isOtpSent");

        print(data);
        print('OTP sent sucessfully');
        return data;
      } else {
        showToast(
          "Invalid Mobile no. Try again!",
          position: StyledToastPosition.top,
          context: context,
          animation: StyledToastAnimation.slideFromLeft,
          reverseAnimation: StyledToastAnimation.slideToLeft,
          duration: Duration(seconds: 4),
          animDuration: Duration(seconds: 1),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
          // backgroundColor: Colors.red,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // void _sendOtp() {
  //   // You can implement your own logic here to send OTP.
  //   // For this example, we'll just simulate that OTP is sent.
  //   setState(() {
  //     isOtpSent = true;
  //     userInputController.text = '';
  //   });
  // }

  Future<void> _verifyOtp(String userPhNumber, String otp) async {
    // You can implement your own logic here to verify OTP.
    // For this example, we'll just simulate that OTP is verified.
    try {
      final response = await http.post(
        Uri.parse('http://console-api.theja.in/validateOtp/$userPhNumber/$otp'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        print(data);
        print('OTP verified sucessfully');
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
                      builder: (context) => NewPasswordPage(id: userPhNumber),
                    ),
                  ); // Add your button's functionality here
                },
                child: Text('ok'.tr),
              ),
            ],
          ),
        );
        return data;
      } else {
        // Handle incorrect OTP case here
        // showDialog(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Text('Error'),
        //     content: Text('Incorrect OTP. Please try again.'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
        showToast(
          "Wrong OTP Try again!",
          position: StyledToastPosition.top,
          context: context,
          animation: StyledToastAnimation.slideFromRight,
          reverseAnimation: StyledToastAnimation.slideToRight,
          duration: Duration(seconds: 4),
          animDuration: Duration(seconds: 1),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
          // backgroundColor: Colors.red,
          textStyle: TextStyle(color: Colors.white, fontSize: 16),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _resendOtp() {
    // Start the timer
    _startResendTimer();

    // Disable the button
    setState(() {
      isOtpSent = false;
    });
    // Implement your OTP resend logic here.
    // You can reset the timer or send a new OTP.
    // For this example, we'll just simulate resending OTP.
    _sendOtp(userInputController.text);
  }

  void _startResendTimer() {
    _remainingTime = 30; // Reset the timer to 30 seconds
    _resendTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _resendTimer?.cancel(); // Cancel the timer when it reaches 0
          _resendTimer = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 165, 227, 106),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'forgot-pass'.tr,
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
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedCard(
                      direction: AnimatedCardDirection
                          .right, // Choose your animation direction
                      initDelay: Duration(
                          milliseconds: 300), // Delay for the initial animation
                      // curve: Curves.easeInBack,
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
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
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "mobile/email".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: userInputController,
                                enabled: !isOtpSent,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
                                  hintText: "enter_mobile/email".tr,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              if (isOtpSent)
                                Text(
                                  "OTP".tr,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              if (isOtpSent)
                                TextFormField(
                                  controller: otpController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                        4), // Limit the input length to 4 digits
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0),
                                    hintText: "enter_otp".tr,
                                  ),
                                ),
                              SizedBox(height: 20.0),
                              Center(
                                child: ElevatedButton(
                                  onPressed: isOtpSent
                                      ? () => _verifyOtp(
                                          userInputController.text.toString(),
                                          otpController.text.toString())
                                      : () {
                                          // Start the timer when clicking the "Send OTP" button
                                          _startResendTimer();
                                          _sendOtp(userInputController.text
                                              .toString());
                                        },
                                  child: Text(isOtpSent
                                      ? "verify_otp".tr
                                      : "send_otp".tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 26, 93, 28),
                                    fixedSize: Size(650, 50),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'go_to_signin'.tr,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
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
                              if (isOtpSent && _resendTimer == null)
                                TextButton(
                                  onPressed: _resendOtp,
                                  child: Text(
                                    "Resend OTP",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              if (isOtpSent && _resendTimer != null)
                                Text(
                                  "Resend OTP in $_remainingTime seconds",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
