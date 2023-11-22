// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';

import '../pages/home_page.dart';

// Existing ForgotPasswordPage code...

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

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
                                  builder: (context) => const Homepage(),
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 227, 106),

        iconTheme: const IconThemeData(color: Colors.black),
         title:  Text('new_pass'.tr, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const Langscreen(),),);
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
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "enter_new_pass".tr,
                            labelText: "enter_new_pass".tr,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: confirmNewPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "confirm_pass".tr,
                            labelText: "confirm_pass".tr,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Center(
                          child: ElevatedButton(
                            onPressed: _updatePassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              fixedSize: const Size(650, 50),
                            ),
                            child: Text("update_pass".tr),
                          ),
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
                                    builder: (context) => const SingIN(),
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
