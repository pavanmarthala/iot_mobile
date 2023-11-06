import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:http/http.dart' as http;

class NewPasswordPage extends StatefulWidget {
  final String id;

  NewPasswordPage({required this.id});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState(id: id);
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final String id;

  _NewPasswordPageState({required this.id});
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void updateNewPin(
    int newPin,
    int confirmPin,
  ) async {
    // You can implement your own logic here to verify OTP.
    // For this example, we'll just simulate that OTP is verified.

    if (newPin != confirmPin) {
      showToast(
        "Passwords do not match. Try again!",
        position: StyledToastPosition.bottom,
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
      return;
    }

    final Map<String, dynamic> requestData = {"id": id, "pin": newPin};

    try {
      final response = await http.post(
        Uri.parse('http://console-api.theja.in/updatePassword'),
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Successfully updated Pin");
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('success'.tr),
            content: Text('New Pin Updated'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SingIN(),
                    ),
                  ); // Add your button's functionality here
                },
                child: Text('ok'.tr),
              ),
            ],
          ),
        );
      } else {
        // Handle incorrect pin case here
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
          "Unable to update PIN, please try again!",
          position: StyledToastPosition.bottom,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 227, 106),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'new_pass'.tr,
          style: TextStyle(
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
                backgroundColor: Color.fromARGB(255, 165, 227, 106),

                // backgroundImage: AssetImage('assets/language-icon.png'),
                child: SvgPicture.asset(
                  'assets/language-icon.svg',
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'new_pass'.tr,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "enter_new_pass".tr,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: newPasswordController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintText: "enter_new_pass".tr,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "confirm_pass".tr,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: confirmNewPasswordController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintText: "confirm_pass".tr,
                              labelText: "confirm_pass".tr,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: AnimatedButton(
                                onTap: () => {
                                      updateNewPin(
                                          int.parse(newPasswordController.text
                                              .toString()),
                                          int.parse(confirmNewPasswordController
                                              .text
                                              .toString()))
                                    },
                                animationDuration:
                                    const Duration(milliseconds: 2000),
                                initialText: "update_pass".tr,
                                finalText: "PIN Updated",
                                iconData: Icons.check,
                                iconSize: 32.0,
                                buttonStyle: buttonstyle(
                                  primaryColor: Colors.green.shade600,
                                  secondaryColor: Colors.white,
                                  initialTextStyle: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                  finalTextStyle: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.green.shade600,
                                  ),
                                  elevation: 20.0,
                                  borderRadius: 10.0,
                                )),
                          ),
                          const SizedBox(height: 10),
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
                                  );
                                },
                                child: Text(
                                  "click".tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
