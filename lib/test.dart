// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // import 'package:shared_preferences/shared_preferences.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       initialRoute: '/',
// //       routes: {
// //         '/': (context) => UserPage(),
// //         '/deviceIds': (context) => DeviceIdsPage(),
// //       },
// //     );
// //   }
// // }

// // class UserPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('User Info'),
// //       ),
// //       body: UserList(),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.pushNamed(context, '/deviceIds');
// //         },
// //         child: Icon(Icons.arrow_forward),
// //       ),
// //     );
// //   }
// // }

// // class DeviceIdsPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Device IDs'),
// //       ),
// //       body: DeviceList(),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.pop(context);
// //         },
// //         child: Icon(Icons.arrow_back),
// //       ),
// //     );
// //   }
// // }

// // class UserList extends StatefulWidget {
// //   @override
// //   _UserListState createState() => _UserListState();
// // }

// // class _UserListState extends State<UserList> {
// //   Future<Map<String, dynamic>>? userInfo;

// //   @override
// //   void initState() {
// //     super.initState();
// //     userInfo = fetchUserInfo();
// //   }

// //   Future<Map<String, dynamic>> fetchUserInfo() async {
// //     // SharedPreferences prefs = await SharedPreferences.getInstance();
// //     // String? jwtToken = prefs.getString('jwt_token'); // Retrieve the JWT token from local storage

// //     // if (jwtToken == null) {
// //     //   // Handle the case where the token is not found
// //     //   // return null;
// //     // }
// //     final response = await http.get(
// //       Uri.https('console-api.theja.in', '/user/getInfo'),
// //       headers: {
// //         "Authorization":
// //             "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI5Njc2MzE2MTY0IiwiYXV0aG9yaXRpZXMiOlsiYWRtaW4iXSwidWlkIjo5NzU1LCJpYXQiOjE2OTc1NDM4MjksImV4cCI6MTcyOTA3OTgyOX0.lJnSjgl1-ZeyYjHniPkNhijiz7PMRgc98yBJOzF7baHB3vzWJmB4AGIw8DQXOmO6-zsy-dY47j96lnrKSq5bBw"
// //       },
// //     );

// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> jsonResponse = json.decode(response.body);
// //       return jsonResponse;
// //     } else {
// //       print('API Response (Error): ${response.body}');
// //       throw Exception('Failed to load user information');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<Map<String, dynamic>>(
// //       future: userInfo,
// //       builder: (context, userSnapshot) {
// //         if (userSnapshot.connectionState == ConnectionState.waiting) {
// //           return Center(child: CircularProgressIndicator());
// //         } else if (userSnapshot.hasError) {
// //           return Center(child: Text('Error: ${userSnapshot.error}'));
// //         } else {
// //           final userInfoData = userSnapshot.data;

// //           return Column(
// //             children: [
// //               Text('User Name: ${userInfoData?["name"] ?? "Unknown"}'),
// //               Text('Subscription Validity: ${userInfoData?["subscriptionValidity"] ?? "Unknown"}'),
// //             ],
// //           );
// //         }
// //       },
// //     );
// //   }
// // }
// class DeviceList extends StatefulWidget {
//   @override
//   _DeviceListState createState() => _DeviceListState();
// }

// class _DeviceListState extends State<DeviceList> {
//   Future<List<String>>? deviceIds;

//   @override
//   void initState() {
//     super.initState();
//     deviceIds = fetchDeviceIds();
//   }

//  Future<List<String>> fetchDeviceIds() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? jwtToken = prefs.getString('jwt_token'); // Retrieve the JWT token from local storage

//   if (jwtToken == null) {
//     // Handle the case where the token is not found
//     // return null;
//   }
//   final response = await http.get(
//     Uri.https('console-api.theja.in', '/user/getInfo'), // Use the correct endpoint
//     headers: {
//       "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI5Njc2MzE2MTY0IiwiYXV0aG9yaXRpZXMiOlsiYWRtaW4iXSwidWlkIjo5NzU1LCJpYXQiOjE2OTc1NDM4MjksImV4cCI6MTcyOTA3OTgyOX0.lJnSjgl1-ZeyYjHniPkNhijiz7PMRgc98yBJOzF7baHB3vzWJmB4AGIw8DQXOmO6-zsy-dY47j96lnrKSq5bBw",
//     },
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       final List<dynamic> deviceIdsJson = jsonResponse["deviceIds"];


//     if (deviceIdsJson is List) {
//       final deviceIds = deviceIdsJson.map((deviceIdJson) => deviceIdJson.toString()).toList();
//       return deviceIds;
//     } else {
//       return <String>[];
//     }
//   } else {
//     print('API Response (Error): ${response.body}');
//     throw Exception('Failed to load device IDs');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: deviceIds,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           final deviceIdsList = snapshot.data;

//           if (deviceIdsList == null || deviceIdsList.isEmpty) {
//             return Center(child: Text('No device IDs found.'));
//           }

//           return Center(
//             child: SizedBox(
//               child: ListView.builder(
//                 itemCount: deviceIdsList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title:  SingleChildScrollView(
//                       child: Column(
//                         children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
//                               child: ElevatedButton(
//                                 onPressed: () {

//                                   Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) =>  Homepages(deviceIdsList[index]),
//       ),
//     );
//                                   // Handle button press for each device
//                                   // You can navigate to a specific page or perform other actions here
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       deviceIdsList[index],
//                                       style: TextStyle(
//                                         color: const Color.fromARGB(255, 195, 51, 41),
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Color.fromARGB(223, 240, 200, 200),
//                                   fixedSize: Size(770, 60),
//                                   side: BorderSide(
//                                     color: Color.fromARGB(255, 218, 117, 110),
//                                     width: 2,
//                                     style: BorderStyle.solid,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     )
//                   );
//                 },
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }


// // class Homepages extends StatefulWidget {
// //   //  const Homepages({super.key,  this.deviceId});

// //  final String deviceId;

// //   Homepages(this.deviceId);

// //   @override
// //   State<Homepages> createState() => _HomepageState();
// // }

// // class _HomepageState extends State<Homepages> {
// //   int index =0;
// //    final screens = [
// //   // DeviceDetailPage(),
// //    ];
   


// //   @override
// //   Widget build(BuildContext context) {

// //     return  Scaffold(
// //        backgroundColor: const Color(0xffcbcbcb),
// //       //  drawer: MyDrawer(),
// //        appBar: AppBar(
// //         iconTheme: IconThemeData(color: Colors.black),
// //          title:  Text("dashboard".tr, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
// //          actions: [
// //           Padding(
// //             padding: EdgeInsets.symmetric(vertical: 1.0,),
// //             child: GestureDetector(
// //               onTap: (){
// //                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>(),),);
// //               },
// //               child: CircleAvatar(
// //                 radius: 18,
// //                 backgroundColor: Colors.green,
// //                 // backgroundImage: AssetImage('assets/language-icon.png'), 
// // //                 child: SvgPicture.asset(
// // //   'assets/language-icon.svg',
// // //   // width: 100.0, // Adjust the width as needed
// // //   // height: 100.0, // Adjust the height as needed
// // // ),

// //               ),
// //             ),
// //           ),
// //            Padding(
// //              padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 20.0),
// //              child: CircleAvatar(
// //                radius: 16,
// //                backgroundColor: Colors.green,
// //                child: IconButton(onPressed: () {
// //                 //  Navigator.of(context).push(
// //                 //  MaterialPageRoute(builder: (context) =>Settings(),),);
// //                   },
// //                   icon: Icon(Icons.settings, size: 30,color: Colors.black,)),
// //              ),
// //            ),
// //          ],
// //        ),
// //        body:  SingleChildScrollView(
// //       scrollDirection: Axis.vertical,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(left: 30, top: 20),
// //             child: Row(
// //               children: [
// //                 Text(
// //                   'device_no:'.tr,
// //                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// //                 ),
// //                   Text(
// //                   '${widget.deviceId}',
// //                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// //                 ),
// //                 SizedBox(width: 140),
// //                      Container(
// //                       height: 30,
// //                       width: 30,
// //                        child: GestureDetector(
// //                           onTap: (){}, // Call handleRefresh when the icon is tapped
// //                           child: Image.asset("assets/refresh.png",)
// //                         ),
// //                      ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 25,),
// //           Padding(
// //             padding: const EdgeInsets.only(left: 15),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   height: 180,
// //                   width: 380,
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                         child: Container(
// //                             height: 70,
// //                             width: 380,
// //                             decoration: BoxDecoration(
// //                                 color:  Color.fromARGB(255, 192, 27, 16) ,
// //                               borderRadius: BorderRadius.only(
// //                                   topRight: Radius.circular(30),
// //                                   topLeft: Radius.circular(30)),
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(20),
// //                               child: Row(
// //                                 children: [
// //                                   Text('motor_switch'.tr,
// //                                       style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontWeight: FontWeight.bold,
// //                                           fontSize: 20),
// //                                   ),
// //                                   SizedBox(width: 120,),
// //                                   Text(  
// //                                     'off'.tr,
// //                                       style: TextStyle(
// //                                           color: Colors.white,
// //                                           fontWeight: FontWeight.bold,
// //                                           fontSize: 20),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         flex: 2,
// //                         child: Row(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.only(top:30.0,left: 10),
// //                               // child: Switch(

// //                               //   onChanged: (value) {
// //                               //     // setState(() {
// //                               //     //   switchState.toggleSwitch();
// //                               //     //   isSwitched = value;
// //                               //     //   motorSwitch = DateTime.now();


// //                               //     // });
// //                               //   },
// //                               //   activeTrackColor: Colors.green,
// //                               //   activeColor: Colors.white,
// //                               //   inactiveTrackColor: Colors.red,
// //                               //   inactiveThumbColor: Colors.white, value: switchState.isSwitched,
// //                               // ),
// //                             ),
// //                             SizedBox(width: 58),
// //                             Row(
// //                               children: [
// //                                 Padding(
// //                                   padding: const EdgeInsets.only(top: 40),
// //                                   child: Text(
// //                                     'last_on'.tr,
// //                                     style: TextStyle(
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 20,
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 // Padding(
// //                                 //   padding: const EdgeInsets.only(top: 40),
// //                                 //   child: Text(
// //                                 //     '${DateFormat('jms').format(motorSwitch)} ',
// //                                 //     style: TextStyle(
// //                                 //       fontWeight: FontWeight.bold,
// //                                 //       fontSize: 20,
// //                                 //     ),
// //                                 //   ),
// //                                 // ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 25,),
// //           Padding(
// //             padding: const EdgeInsets.only(left: 15),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   height: 180,
// //                   width: 380,
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                         child: Container(
// //                           height: 70,
// //                           width: 380,
// //                           decoration: BoxDecoration(
// //                             color: Color.fromARGB(255, 192, 27, 16),
// //                             borderRadius: BorderRadius.only(
// //                               topRight: Radius.circular(30),
// //                               topLeft: Radius.circular(30),
// //                             ),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(20),
// //                             child: Row(
// //                               children: [
// //                                 Text(
// //                                   'power_status'.tr,
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 20,
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 120,),
// //                                 Text(
// //                                   'on'.tr,
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 20,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         flex: 2,
// //                         child: Row(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(13.0),
// //                               child: Image.asset("assets/power.png")
// //                             ),
// //                             SizedBox(width: 10,),
// //                             Text(
// //                               'last_on'.tr,
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 20,
// //                               ),
// //                             ),
// //                             // Text(
// //                             //   '${DateFormat('jms').format(time)} ',
// //                             //   style: TextStyle(
// //                             //     fontWeight: FontWeight.bold,
// //                             //     fontSize: 20,
// //                             //   ),
// //                             // ),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 25,),
// //           Padding(
// //             padding: const EdgeInsets.only(left: 15),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   height: 180,
// //                   width: 380,
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                         child: Container(
// //                           height: 70,
// //                           width: 380,
// //                           decoration: BoxDecoration(
// //                             color: Color.fromARGB(255, 192, 27, 16),
// //                             borderRadius: BorderRadius.only(
// //                               topRight: Radius.circular(30),
// //                               topLeft: Radius.circular(30),
// //                             ),
// //                           ),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(20),
// //                             child: Row(
// //                               children: [
// //                                 Text(
// //                                   'motor_status'.tr,
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 20,
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 120,),
// //                                 Text(
// //                                   'on'.tr,
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontWeight: FontWeight.bold,
// //                                     fontSize: 20,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         flex: 2,
// //                         child: Row(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.all(10.0),
// //                               child: Image.asset("assets/motor.jpeg")
// //                             ),
// //                             SizedBox(width: 15,),
// //                             Text(
// //                               'last_on'.tr,
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 20,
// //                               ),
// //                             ),
// //                             // Text(
// //                             //   // '${DateFormat('jms').format(time)}',
// //                             //   style: TextStyle(
// //                             //     fontWeight: FontWeight.bold,
// //                             //     fontSize: 20,
// //                             //   ),
// //                             // ),
// //                           ],
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(height: 25,),
// //         ],
// //       ),
// //     ),
       
// //        bottomNavigationBar: NavigationBarTheme(
// //         data: NavigationBarThemeData(
// //           indicatorColor: Colors.blue.shade100,
// //           labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
// //         ),
// //          child: NavigationBar(
// //           height: 60,
// //           backgroundColor:Colors.green ,
// //              selectedIndex: index,
// //           onDestinationSelected: (index) => 
// //           setState(() => this.index = index),

// //           destinations: [
// //           NavigationDestination(
// //             icon:Icon(Icons.signal_cellular_alt_outlined, ),
// //             // selectedIcon:Icon(Icons.signal_cellular_alt_outlined, ) ,
// //              label:'status'.tr),
       
// //                NavigationDestination(
// //             icon:Icon(Icons.format_list_bulleted),
// //              label:'logs'.tr)
// //          ]),
// //        ),
      
// //     );
// //   }
// // }




