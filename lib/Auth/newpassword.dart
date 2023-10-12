import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';

import '../pages/Home_page.dart';

// Existing ForgotPasswordPage code...

class NewPasswordPage extends StatefulWidget {
  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void _updatePassword() {
    // You can implement your own logic here to update the password.
    // For this example, we'll just simulate the update.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('success'.tr),
        content: Text('pass_verified'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                              );
              // Navigate back to the sign-in page or any other page as needed.
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
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'new_pass'.tr,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "enter_new_pass".tr,
                            labelText: "enter_new_pass".tr,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: confirmNewPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "confirm_pass".tr,
                            labelText: "confirm_pass".tr,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Center(
                          child: ElevatedButton(
                            onPressed: _updatePassword,
                            child: Text("update_pass".tr),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              fixedSize: Size(650, 50),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                );
                              },
                              child: Text(
                                "click".tr,
                                style: TextStyle(
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
