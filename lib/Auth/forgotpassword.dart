// ignore_for_file: prefer_const_constructors, sort_child_properties_last, library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:convert';

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
        print("OPT sent");
        //   isOtpSent = true;
        setState(() {
          isOtpSent = true;
        });
        print("OTP staus:  $isOtpSent");

        print(data);
        print('OTP sent sucessfully');
        return data;
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
                      builder: (context) => NewPasswordPage(),
                    ),
                  ); // Add your button's functionality here
                },
                child: Text('ok'.tr),
              ),
            ],
          ),
        );
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _resendOtp() {
    // Implement your OTP resend logic here.
    // You can reset the timer or send a new OTP.
    // For this example, we'll just simulate resending OTP.
    _sendOtp(userInputController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                  : () => _sendOtp(
                                      userInputController.text.toString()),
                              child: Text(
                                  isOtpSent ? "verify_otp".tr : "send_otp".tr),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .green, // Change the button's background color
                                fixedSize:
                                    Size(650, 50), // Increase the button's size
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
                              SizedBox(
                                width: 6,
                              ),
                              if (isOtpSent)
                                TextButton(
                                  onPressed: _resendOtp,
                                  child: Text(
                                    "Resend OTP".tr,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   TextEditingController userInputController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   bool isOtpSent = false;

   

//   void _verifyOtp() {
//     // You can implement your own logic here to verify OTP.
//     // For this example, we'll just simulate that OTP is verified.
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Success'),
//         content: Text('OTP verified successfully!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewPasswordPage(),),); // Add your button's functionality here

//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           backgroundColor: Colors.green,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Card(
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),

//                   decoration: BoxDecoration(
//                     //gradient: LinearGradient(
//                      // colors: [Colors.white, Colors.green],
//                      // begin: Alignment.topCenter,
//                      // end: Alignment.bottomCenter,
//                    // ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),

//                   child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [

//                       Text(
//                           'Forgot Password',
//                           style: TextStyle(
//                               fontSize: 20),
//                         ),
//                         SizedBox(height:10),
//                        TextFormField(
//                           controller: userInputController,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                               hintText: "Enter your Mobile number or Email",

//                               labelText: "Registered Mobile/Email"),
//                         ),
//                       SizedBox(height: 10.0),
//                       if (isOtpSent)
//                         TextFormField(
//                           controller: otpController,
//                           decoration: InputDecoration(
//                             labelText: "Enter OTP",
//                             hintText: "Enter your Mobile number or Email",

//                           ),
//                         ),
//                       SizedBox(height: 10.0),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: isOtpSent ? _verifyOtp : _sendOtp(userInputController.text.toString()),
//                           child: Text(isOtpSent ? "Verify OTP" : "Send OTP"),
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors
//                                 .green, // Change the button's background color
//                             fixedSize:
//                                 Size(650, 50), // Increase the button's size
//                           ),

//                         ),
//                       ),
//                       SizedBox(height: 10,),
//                        Row(
//                           children: [
//                             Text(
//                               'Go Back to Singin?',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             TextButton(
//                               onPressed: () {

//                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SingIN(),),); // Add your button's functionality here
//                               },
//                               child: Text(
//                                 "Click Here",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                   // Change the text color as needed
//                                   fontSize:
//                                       16, // Adjust the text size as needed
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
