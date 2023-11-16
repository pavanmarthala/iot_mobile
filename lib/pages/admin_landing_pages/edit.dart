// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsScreen extends StatefulWidget {
  final String mobileId;

  UserDetailsScreen(
      {required this.mobileId, Key? key, required String deviceIdId})
      : super(key: key);
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // Define user details
  String name = "";
  String firstname = "";
  String lastname = "";
  String mobileNumber = "";
  String email = "";
  String role = "";
  String status = "";
  String pin = "";
  String language = "";
  String zone = "";
  String subscriptionValid = "";
  String address1 = "";
  String address2 = "";
  String address3 = "";
  String landmark = "";
  String city = "";
  String district = "";
  String state = "";
  String pincode = "";
  List<String> deviceIds = [];

  // Controller for the editable text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController zoneController = TextEditingController();
  final TextEditingController subscriptionValidController =
      TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController address3Controller = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  bool isEditing = false;
  List<String> editingdeviceIds = [];
  @override
  void initState() {
    super.initState();
    // Fetch user details from the API
    fetchUserDetails();
  }

  // Function to fetch user details from the API
  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwt_token');

    if (jwtToken == null) {
      // Handle the case where the token is not found
      // return null;
    }
    final response = await http.get(
      Uri.https('console-api.theja.in', '/admin/getUser/${widget.mobileId}'),
      headers: {
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      print(response.body);

      setState(() {
        name = userData['userDetails']['name'] ?? 'N/A';
        firstname = userData['userDetails']['firstName'];
        lastname = userData['userDetails']['lastName'];
        mobileNumber = userData['mobile'];
        email = userData['email'] ?? 'N/A';
        role = userData['role'];
        status = userData['active'] ? 'Active' : 'Inactive';
        pin = userData['pin'] ?? 'N/A';
        language = userData['preferredLanguage'];
        zone = userData['zone'];
        subscriptionValid = userData['subscriptionValidity'];
        final addressData = userData['userDetails']['address'];
        address1 = '${addressData['addressLine1']},';
        address2 = '${addressData['addressLine2']}';
        address3 = '${addressData['addressLine3']}';
        landmark = '${addressData['landMark']}';
        city = '${addressData['city']}';
        state = '${addressData['state']}';
        district = '${addressData['district']}';
        pincode = '${addressData['pinCode']}';
        deviceIds =
            (userData['deviceIds'] as List).map((id) => id.toString()).toList();

        // Initialize the controllers with the fetched user details
        nameController.text = name;
        firstnameController.text = firstname;
        lastnameController.text = lastname;
        mobileNumberController.text = mobileNumber;
        emailController.text = email;
        roleController.text = role;
        statusController.text = status;
        pinController.text = pin;
        languageController.text = language;
        zoneController.text = zone;
        subscriptionValidController.text = subscriptionValid;
        address1Controller.text = address1;
        address2Controller.text = address2;
        address3Controller.text = address3;
        landmarkController.text = landmark;
        cityController.text = city;
        districtController.text = district;
        stateController.text = state;
        pincodeController.text = pincode;
      });
    } else {
      // Handle the error when the API request fails
      print('Failed to fetch user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        title: Text('user_deatils'.tr),
        actions: [
          isEditing
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    // Save the edited user details here
                    setState(() {
                      name = nameController.text;
                      lastname = lastnameController.text;
                      firstname = firstnameController.text;
                      mobileNumber = mobileNumberController.text;
                      email = emailController.text;
                      role = roleController.text;
                      status = statusController.text;
                      pin = pinController.text;
                      language = languageController.text;
                      zone = zoneController.text;
                      subscriptionValid = subscriptionValidController.text;
                      address1 = address1Controller.text;
                      address2 = address2Controller.text;
                      address3 = address3Controller.text;
                      landmarkController.text = landmark;
                      city = cityController.text;
                      district = districtController.text;
                      state = stateController.text;
                      pincode = pincodeController.text;
                      deviceIds = editingdeviceIds;
                      isEditing = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditing = true;
                      editingdeviceIds = List<String>.from(deviceIds);
                    });
                  },
                ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _UserDetail("mobile_number".tr, mobileNumberController, false),
            _buildUserDetail("email_id".tr, emailController),
            _buildUserDetail("role".tr, roleController),
            _UserDetail("status".tr, statusController, false),
            _buildUserDetail("pin".tr, pinController),
            _buildUserDetail("language ".tr, languageController),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                // height: 200,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //   color: Colors.black, // Border color
                  //   width: 1.0, // Border width
                  //   style: BorderStyle
                  //       .solid, // Border style (you can use dotted or dashed too)
                  // ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'device_ids'.tr,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Wrap(
                          children: <Widget>[
                            for (int i = 0; i < deviceIds.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 380,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.teal.withOpacity(0.2),
                                          Colors.lightGreen,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //   color: Colors.black, // Border color
                                      //   width: 1.0, // Border width
                                      //   style: BorderStyle
                                      //       .solid, // Border style (you can use dotted or dashed too)
                                      // ),
                                    ),
                                    child: Center(child: Text(deviceIds[i]))),
                              ),

                            // Display the editing deviceIds
                            if (isEditing)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      for (int i = 0;
                                          i < editingdeviceIds.length;
                                          i++)
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    TextEditingController(
                                                        text: editingdeviceIds[
                                                            i]),
                                                onChanged: (value) {
                                                  // Update the editingdeviceIds list
                                                  editingdeviceIds[i] = value;
                                                },
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  editingdeviceIds.removeAt(i);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            editingdeviceIds.add("");
                                          });
                                        },
                                        child: Text("add".tr),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildUserDetail("zone".tr, zoneController),
            _SubscriptionDetail("sub".tr, subscriptionValidController),
            Text(
              'user_deatils'.tr,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            _UserDetail("name".tr, nameController, false),
            _UserDetail("first_number".tr, firstnameController, false),
            _UserDetail("last_name".tr, lastnameController, false),
            Text(
              'address'.tr,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            _buildUserDetail(
              "name".tr,
              nameController,
            ),
            _buildUserDetail(
              "first_number".tr,
              firstnameController,
            ),
            _buildUserDetail(
              "last_name".tr,
              lastnameController,
            ),
            _buildUserDetail("address1".tr, address1Controller),
            _buildUserDetail("address2".tr, address2Controller),
            _buildUserDetail("address3".tr, address3Controller),
            _buildUserDetail("land_mark".tr, landmarkController),
            _buildUserDetail("city".tr, cityController),
            _buildUserDetail("district".tr, districtController),
            _buildUserDetail("state".tr, stateController),
            _buildUserDetail("pincode".tr, pincodeController),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetail(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.2),
              Colors.lightGreen,
            ],
          ),
          // border: Border.all(
          //   color: Colors.black, // Border color
          //   width: 1.0, // Border width
          //   style: BorderStyle
          //       .solid, // Border style (you can use dotted or dashed too)
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              isEditing
                  ? TextField(
                      controller: controller,
                    )
                  : Text(
                      controller.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _UserDetail(
      String label, TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.2),
              Colors.lightGreen,
            ],
          ),
          // border: Border.all(
          //   color: Colors.black, // Border color
          //   width: 1.0, // Border width
          //   style: BorderStyle.solid, // Border style
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              editable
                  ? TextField(
                      controller: controller,
                    )
                  : Text(
                      controller.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SubscriptionDetail(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.2),
              Colors.lightGreen,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Colors.black, // Border color
          //   width: 1.0, // Border width
          //   style: BorderStyle.solid, // Border style
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              isEditing
                  ? SubscriptionValidityTextField()
                  : Text(
                      controller.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionValidityTextField extends StatefulWidget {
  @override
  _SubscriptionValidityTextFieldState createState() =>
      _SubscriptionValidityTextFieldState();
}

class _SubscriptionValidityTextFieldState
    extends State<SubscriptionValidityTextField> {
  DateTime _dateTime = DateTime.now();
  TextEditingController _subscriptioncontroller = TextEditingController();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        // Format the date to display only the date part
        final formattedDate = DateFormat('yyyy/MM/dd').format(value);

        setState(() {
          _dateTime = value;
          _subscriptioncontroller.text =
              formattedDate; // Update the date in the TextField
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: _showDatePicker,
      controller: _subscriptioncontroller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        hintText: 'select_validity'.tr,
      ),
    );
  }
}
