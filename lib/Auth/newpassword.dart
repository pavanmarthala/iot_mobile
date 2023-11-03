import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/animited_button.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';

class NewPasswordPage extends StatefulWidget {
  final String id; // Add this line

  NewPasswordPage({required this.id}); // Add this constructor

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState(id: id);
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final String id; // Store the user's ID

  _NewPasswordPageState({required this.id});
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

<<<<<<< HEAD
  Future<void> _updatePassword() async {
    String newPassword = newPasswordController.text;
    String confirmNewPassword = confirmNewPasswordController.text;

    // Check if passwords match
    if (newPassword != confirmNewPassword) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Send a POST request to the API to update the password
    final Map<String, dynamic> requestData = {
      "newPassword": newPassword,
      "id": id, // Pass the user's ID when updating the password
    };
    try {
      final response = await http.post(
        Uri.parse('https://console-api.theja.in/updatePassword'),
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        print(data);
        print('Password updated successfully');

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Password updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Adminlandingpage(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
=======
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
                  builder: (context) => Adminlandingpage(),
                ),
              );
              // Navigate back to the sign-in page or any other page as needed.
            },
            child: Text('ok'.tr),
>>>>>>> e787e51550fd7a7f8998b89497a0deeae7cdaac3
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
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              hintText: "confirm_pass".tr,
                              labelText: "confirm_pass".tr,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          // Center(
                          //   child: ElevatedButton(
                          //     onPressed: _updatePassword,
                          //     child: Text("update_pass".tr),
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.green,
                          //       fixedSize: Size(650, 50),
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: AnimatedButton(
                                onTap: _updatePassword,
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
