

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'  as http;
import 'package:iot_mobile_app/pages/Home_page.dart';


class Adduser extends StatefulWidget {
  const Adduser({super.key});



  @override
  State<Adduser> createState() => _dataState();


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


  void addUser() async {


    // Create a data model to represent the data you want to send
    var userData = {
      "active": true,
      "email": _emailController.text,
      "mobile": _mobileNocontroller.text,
      "pin": _pinController.text,
      "preferredLanguage": _languagecontroller.text,
      "role": _rolecontroller.text,
      "subscriptionValidity": _subscriptioncontroller.text,
      "userDetails": {
        "address": {
          "addressLine1": _address1controller.text,
          "addressLine2": _address2controller.text,
          "addressLine3": _address3controller.text,
          "city": _citycontroller.text,
          "district": _districtcontroller.text,
          "landMark": _landmarkcontroller.text,
          "pinCode": _pinController.text,
          "state": _statecontroller.text,
        },
        "firstName": _firstnameController.text,
        "lastName": _lastnameController.text,
        "name": "${_firstnameController.text} ${_lastnameController.text}",
      },
      "zone": _zonecontroller.text,
    };
    final jsonString = json.encode(userData);
    final url = Uri.parse('https://console-api.theja.in/admin/addUser');
    final headers = {
    "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJLVGVjaF9Jb1QiLCJzdWIiOiI4NTAwOTMwMDg4IiwiYXV0aG9yaXRpZXMiOlsidXNlciJdLCJ1aWQiOjk2ODYsImlhdCI6MTY5NzExODQyMiwiZXhwIjoxNzI4NjU0NDIyfQ.8XCTMjvBY65rKT_xqRTymRlD5K5IdgN5dwjz0hUPEP5oC2AJQw_N22y4PGV538NsiegYjZNIIKVddZ84X1zmyg"
    };

try {
  final response = await http.post(url, headers: headers, body: jsonString);
 print(response);
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => Homepage(),),);
}
catch(e){

  print(e.toString());
  print("error");

}
  }


  // var params = {
  //   "doctor_id": "DOC000506",
  //   "date_range": "25/03/2019-25/03/2019" ,
  //   "clinic_id":"LAD000404"      };
  //
  // var response = await http.post("http://theapiiamcalling:8000",
  // body: json.encode(params)
  // ,headers: {
  // "Authorization": Constants.APPOINTMENT_TEST_AUTHORIZATION_KEY,
  // HttpHeaders.contentTypeHeader: "application/json",
  // "callMethod" : "DOCTOR_AVAILABILITY"
  // });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar:Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: addUser,
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('Add User', style: TextStyle(fontSize: 20)),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text("Add User", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),

              Text(
                'Mobile Number',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _mobileNocontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                ),
              ),

              SizedBox(height: 20,),
              Text(
                'First Name',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  hintText: 'Enter first name',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'last Name',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  hintText: 'Enter last Name',
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Email Id',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email id',
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Subscription validity Till',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _subscriptioncontroller,
                decoration: InputDecoration(
                  hintText: 'select validity',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'PIN',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _pinController,
                decoration: InputDecoration(
                  hintText: 'Enter Device Pin',
                ),
              ),
              SizedBox(height: 20,),



              Text(
                'Preferd language',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _languagecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Preferd language',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'Role',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _rolecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter prefered role',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'Address Line 1',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address1controller,
                decoration: InputDecoration(
                  hintText: 'Enter address line 1',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'Address Line 2',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _address2controller,
                decoration: InputDecoration(
                  hintText: 'Enter address line 2',
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Address Line 3',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                controller: _address3controller,
                decoration: InputDecoration(
                  hintText: 'Enter address line 3',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'State',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _statecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter state',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'District',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _districtcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter district',
                ),
              ),

              Text(
                'zone',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _zonecontroller,
                decoration: InputDecoration(
                  hintText: 'Enter zone',
                ),
              ),
              SizedBox(height: 20,),

              Text(
                'City',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _citycontroller,
                decoration: InputDecoration(
                  hintText: 'Enter city',
                ),
              ),
              SizedBox(height: 20,),


              Text(
                'Land mark',
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _landmarkcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter landmark',
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }


}