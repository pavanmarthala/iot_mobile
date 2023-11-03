// // ignore_for_file: prefer_const_constructors

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// // import 'package:iot_mobile_app/pages/Home_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:iot_mobile_app/animited_button.dart';
// import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
// import 'package:iot_mobile_app/pages/landing_page.dart';
// // import 'package:iot_mobile_app/pages/landing_page.dart';
// import 'package:iot_mobile_app/pages/lang_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'forgotpassword.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class SingIN extends StatefulWidget {
//   @override
//   State<SingIN> createState() => _SingINState();
// }

// class _SingINState extends State<SingIN> {
//   final formkey = GlobalKey<FormState>();

//   final _usernameController = TextEditingController();

//   final _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     checkLoggedInStatus(); // Check the login status when the screen initializes
//   }

//   // Function to check the login status
//   void checkLoggedInStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? username = prefs.getString('username');
//     String? password = prefs.getString('password');

//     if (username != null && password != null) {
//       login(username, password);
//     }
//   }

//   void login(String user, password) async {
//     final Map<String, dynamic> requestData = {
//       "pin": password,
//       "userId": user,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse('https://console-api.theja.in/login'),
//         body: jsonEncode(requestData),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body.toString());
//         print(data);

//         print('account login sucessfully');
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('username', user);
//         prefs.setString('password', password);
//         prefs.setString('jwt_token', data['token']);

//         // Decode the token to check user role
//         final Map<String, dynamic> decodedToken =
//             JwtDecoder.decode(data['token']);
//         List<dynamic> authorities = decodedToken['authorities'];

//         if (authorities.contains('superAdmin') ||
//             (authorities.contains('admin'))) {
//           // Navigate to the admin panel (Adminlandingpage)
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Adminlandingpage(),
//             ),
//           );
//         } else {
//           // Navigate to the user panel (Landingpage)
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Landingpage(),
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 165, 227, 106),
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           'sign_in'.tr,
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 30),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => Langscreen(),
//                   ),
//                 );
//               },
//               child: CircleAvatar(
//                 radius: 18,
//                 backgroundColor: Color.fromARGB(255, 165, 227, 106),

//                 // backgroundImage: AssetImage('assets/language-icon.png'),
//                 child: SvgPicture.asset(
//                   'assets/language-icon.svg',
//                   // width: 100.0, // Adjust the width as needed
//                   // height: 100.0, // Adjust the height as needed
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset(
//             "assets/loginbg.jpg",
//             fit: BoxFit.cover,
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formkey,
//                   child: Center(
//                     child: Card(
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               'log_in_to_console'.tr,
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Text(
//                               "mobile/email".tr,
//                               style: TextStyle(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextField(
//                               controller: _usernameController,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 0),
//                                 // hintText: "mobile/email".tr,
//                                 hintText: "enter_mobile/email".tr,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Text(
//                               "pin".tr,
//                               style: TextStyle(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                               controller: _passwordController,
//                               keyboardType: TextInputType.text,
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 contentPadding: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 0),
//                                 hintText: "enter_pin".tr,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             // ElevatedButton(
//                             //   onPressed: () {
//                             //     login(_usernameController.text.toString(),
//                             //         _passwordController.text.toString());
//                             //   },
//                             //   child: Text(
//                             //     "sign_in".tr,
//                             //     style: TextStyle(fontSize: 20),
//                             //   ),
//                             //   style: ElevatedButton.styleFrom(
//                             //     primary: Color.fromARGB(255, 26, 93, 28),
//                             //     fixedSize: Size(650, 60),
//                             //   ),
//                             // ),
//                             Center(
//                               child: AnimatedButton(
//                                   onTap: () {
//                                     login(_usernameController.text.toString(),
//                                         _passwordController.text.toString());
//                                   },
//                                   animationDuration:
//                                       const Duration(milliseconds: 2000),
//                                   initialText: "sign_in".tr,
//                                   finalText: "Logged In",
//                                   iconData: Icons.check,
//                                   iconSize: 32.0,
//                                   buttonStyle: buttonstyle(
//                                     primaryColor: Colors.green.shade600,
//                                     secondaryColor: Colors.white,
//                                     initialTextStyle: TextStyle(
//                                       fontSize: 22.0,
//                                       color: Colors.white,
//                                     ),
//                                     finalTextStyle: TextStyle(
//                                       fontSize: 22.0,
//                                       color: Colors.green.shade600,
//                                     ),
//                                     elevation: 20.0,
//                                     borderRadius: 10.0,
//                                   )),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   'forgot_password'.tr,
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             ForgotPasswordPage(),
//                                       ),
//                                     ); // Add your button's functionality here
//                                   },
//                                   child: Text(
//                                     "click".tr,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       // Change the text color as needed
//                                       fontSize:
//                                           16, // Adjust the text size as needed
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
