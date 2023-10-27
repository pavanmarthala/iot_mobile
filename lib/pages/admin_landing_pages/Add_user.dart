// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace, camel_case_types, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:iot_mobile_app/models/add_user_model.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/select_destrict.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/select_state.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/select_zone.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
// import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adduser extends StatefulWidget {
  final String? selectedState;

  const Adduser({Key? key, this.selectedState}) : super(key: key);

  @override
  _AdduserrState createState() => _AdduserrState(selectedState: selectedState);
}

class _AdduserrState extends State<Adduser> {
  String? selectedState;
  String? selectedDistrict;

  _AdduserrState({this.selectedState});
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
    AdduserModel? _addusermodel;
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            String mobileNumber = _mobileNocontroller.text;
            String firstName = _firstnameController.text;
            String lastName = _lastnameController.text;
            String email = _emailController.text;
            String subscriptionValidity = _subscriptioncontroller.text;
            String pin = _pinController.text;
            String preferredLanguage = _languagecontroller.text;
            String role = _rolecontroller.text;
            String address1 = _address1controller.text;
            String address2 = _address2controller.text;
            String address3 = _address3controller.text;
            String state = _statecontroller.text;
            String district = _districtcontroller.text;
            String zone = _zonecontroller.text;
            String city = _citycontroller.text;
            String landmark = _landmarkcontroller.text;

            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? jwtToken = prefs.getString('jwt_token');

            if (jwtToken == null) {
              // Handle the case where the token is missing
              return;
            }

            // Prepare the request body to match the API's expected structure
            Map<String, dynamic> requestBody = {
              "active": true,
              "email": email,
              "mobile": mobileNumber,
              "pin": pin,
              "preferredLanguage": preferredLanguage,
              "role": role,
              "subscriptionValidity": subscriptionValidity,
              "userDetails": {
                "address": {
                  "addressLine1": address1,
                  "addressLine2": address2,
                  "addressLine3": address3,
                  "city": city,
                  "district": district,
                  "landMark": landmark,
                  "state": state,
                  "pinCode":
                      "string", // You may want to replace this with an actual pin code
                },
                "firstName": firstName,
                "lastName": lastName,
                "name": "$firstName $lastName",
              },
              "zone": zone,
            };

            // Prepare the headers with the JWT token
            Map<String, String> headers = {
              'Authorization': 'Bearer $jwtToken',
              'Content-Type': 'application/json', // Specify JSON content type
            };

            // Make the API POST request with headers and request body
            Uri apiUrl =
                Uri.parse('https://console-api.theja.in/admin/addUser');
            http
                .post(
              apiUrl,
              headers: headers,
              body: jsonEncode(requestBody), // Convert request body to JSON
            )
                .then((response) {
              if (response.statusCode == 200) {
                // Request was successful
                print('API request successful');
                // Parse the response if needed
                final responseJson = jsonDecode(response.body);
                // Handle the response data as required
              } else {
                // Request failed
                print(
                    'API request failed with status code: ${response.statusCode}');
                print('Response body: ${response.body}');
                // You can handle the error here
              }
            }).catchError((error) {
              // Request failed
              print('API request failed with error: $error');
              // You can handle the error here
            });
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
        title: Text(
          "add_user".tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
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
                backgroundColor: Colors.white,

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'mobile_number'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _mobileNocontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_mobile_number'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'first_number'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'Enter_first_name'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'last_name'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_last_name'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'email_id'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_email'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Subscription_validity'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _subscriptioncontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'select_validity'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'pin'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _pinController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_device_pin'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'language'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _languagecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_preferd_language'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'role'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _rolecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_role'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'address1'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address1controller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_address1'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'address2'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address2controller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_address2'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'address3'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                controller: _address3controller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_address3'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'state'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                onTap: () async {
                  final result = await Navigator.push<StateSelection>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectState(),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _statecontroller.text = result.selectedState;
                    });
                  }
                },
                controller: _statecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_state'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'district'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                onTap: () async {
                  final selectedDistrict =
                      await Navigator.of(context).push<String>(
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectDistrict(_statecontroller.text),
                    ),
                  );

                  if (selectedDistrict != null) {
                    setState(() {
                      _districtcontroller.text = selectedDistrict;
                    });
                  }
                },
                controller: _districtcontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_district'.tr,
                ),
              ),
              Text(
                'zone'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                onTap: () async {
                  final selectedZone = await Navigator.of(context).push<String>(
                    MaterialPageRoute(
                      builder: (context) => SelectZone(
                          _statecontroller.text, _districtcontroller.text),
                    ),
                  );

                  if (selectedZone != null) {
                    setState(() {
                      _zonecontroller.text = selectedZone;
                    });
                  }
                },
                controller: _zonecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_zone'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'city'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _citycontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'enter_city'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'land_mark'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _landmarkcontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
