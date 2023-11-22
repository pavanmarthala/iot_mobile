

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, camel_case_types

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'  as http;
import 'package:iot_mobile_app/models/add_user_model.dart';

class Adduser extends StatefulWidget {
  const Adduser({super.key});



  @override
  State<Adduser> createState() => _dataState();


}
Future<AdduserModel?> add (
  
  String email,
  String mobile,
  String pin,
  String preferredLanguage,
  String role,
  String subscriptionValidity,
  String addressLine1,
  String addressLine2,
  String addressLine3,
  String city,
  String district,
  String landMark,
  // String pinCode,
  String state,
  String firstName,
  String lastName,
  String zone,
  
  )async{
  var response = await http.post(Uri.https('console-api.theja.in','admin/addUser'),
  body:jsonEncode({
       "active": "true",
      "email": email,
      "mobile": mobile,
      "pin": pin,
      "preferredLanguage": preferredLanguage,
      "role": role,
      "subscriptionValidity": subscriptionValidity,
      "userDetails": {
        "address": {
          "addressLine1": addressLine1,
          "addressLine2": addressLine2,
          "addressLine3": addressLine3,
          "city": city,
          "district": district,
          "landMark": landMark,
          // "pinCode": pinCode,
          "state": state,
        },
        "firstName": firstName,
        "lastName": lastName,
        
      },
      "zone":zone,
  }),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI4NTAwOTMwMDg4IiwiYXV0aG9yaXRpZXMiOlsidXNlciJdLCJ1aWQiOjk2ODYsImlhdCI6MTY5NzExODQyMiwiZXhwIjoxNzI4NjU0NDIyfQ.8XCTMjvBY65rKT_xqRTymRlD5K5IdgN5dwjz0hUPEP5oC2AJQw_N22y4PGV538NsiegYjZNIIKVddZ84X1zmyg'
    }, 
  );
  var data =response.body;
  if (kDebugMode) {
    print(data);
  }
  if(response.statusCode == 200){
    String responseString = response.body;
    adduserModelFromJson(responseString);
  }
  else {
    return null;
  }
  return null;
}

class _dataState extends State<Adduser> {

  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _pinController = TextEditingController();
  final _emailController = TextEditingController();
  final _subscriptioncontroller = TextEditingController();
  final _zonecontroller = TextEditingController();
  final _languagecontroller = TextEditingController();
  final _mobileNocontroller = TextEditingController();
  final _rolecontroller = TextEditingController();
  final _address1controller = TextEditingController();
  final _address2controller = TextEditingController();
  final _address3controller = TextEditingController();
  final _statecontroller = TextEditingController();
  final _districtcontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _landmarkcontroller = TextEditingController();






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar:Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: ()async{
              String email = _emailController.text;
             String mobile =_mobileNocontroller.text;
              String pin = _pinController.text;
             String preferredLanguage = _languagecontroller.text;
             String role = _rolecontroller.text;
  String subscriptionValidity = _subscriptioncontroller.text;
  String addressLine1 = _address1controller.text;
  String addressLine2 = _address2controller.text;
  String addressLine3 = _address3controller.text;
  String city = _citycontroller.text;
  String district = _districtcontroller.text;
  String landMark = _landmarkcontroller.text;
  // String pinCode,
  String state = _statecontroller.text;
  String firstName = _firstnameController.text;
  String lastName = _lastnameController.text;
  String zone = _zonecontroller.text;

               AdduserModel? data = await add(
                email, mobile, pin, preferredLanguage,
                 role, subscriptionValidity, addressLine1, 
                 addressLine2, addressLine3, city, district, landMark, state, firstName, lastName, zone);
             if (data != null) {
              setState(() {
              });
            }

          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('add_user'.tr, style: TextStyle(fontSize: 20)),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:  Text("add_user".tr, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Text(
                'mobile_number'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _mobileNocontroller,
                decoration: InputDecoration(
                  hintText: 'enter_mobile_number'.tr,
                ),
              ),

              SizedBox(height: 20,),
              Text(
                'first_number'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  hintText: 'Enter_first_name'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'last_name'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  hintText: 'enter_last_name'.tr,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'email_id'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'enter_email'.tr,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Subscription_validity'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _subscriptioncontroller,
                decoration: InputDecoration(
                  hintText: 'select_validity'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'pin'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _pinController,
                decoration: InputDecoration(
                  hintText: 'enter_device_pin'.tr,
                ),
              ),
              SizedBox(height: 20,),



              Text(
                'language'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _languagecontroller,
                decoration: InputDecoration(
                  hintText: 'enter_preferd_language'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'role'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _rolecontroller,
                decoration: InputDecoration(
                  hintText: 'enter_role'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'address1'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address1controller,
                decoration: InputDecoration(
                  hintText: 'enter_address1'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'address2'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address2controller,
                decoration: InputDecoration(
                  hintText: 'enter_address2'.tr,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'address3'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                controller: _address3controller,
                decoration: InputDecoration(
                  hintText: 'enter_address3'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'state'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _statecontroller,
                decoration: InputDecoration(
                  hintText: 'enter_state'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'district'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _districtcontroller,
                decoration: InputDecoration(
                  hintText: 'enter_district'.tr,
                ),
              ),

              Text(
                'zone'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _zonecontroller,
                decoration: InputDecoration(
                  hintText: 'enter_zone'.tr,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'city'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _citycontroller,
                decoration: InputDecoration(
                  hintText: 'enter_city'.tr,
                ),
              ),
              SizedBox(height: 20,),


              Text(
                'land_mark'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _landmarkcontroller,
                decoration: InputDecoration(
                  hintText: 'enter_land_mark'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }


}