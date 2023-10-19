import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final _deviceController = TextEditingController();
  final _devicenameController = TextEditingController();
  final _pinController = TextEditingController();
  final _simController = TextEditingController();
  final _topiccontroller = TextEditingController();
  final _zonecontroller = TextEditingController();
  final _serialNocontroller = TextEditingController();
  final _mobileNocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            final url = Uri.parse('https://console-api.theja.in/admin/addDevice');
            final jsonData = {
              "active": true,
              "deviceId": _deviceController.text,
              "deviceSerialNumber": _serialNocontroller.text,
              "name": _devicenameController.text,
              "simId": _simController.text,
              "topic": _topiccontroller.text,
              "zone": _zonecontroller.text,
            };

            final jsonString = json.encode(jsonData);

            final headers = {
              "Authorization": "Bearer "
            };

            final response = await http.post(url, headers: headers, body: jsonString);

            if (response.statusCode == 200) {
              // Successful response, you can handle it as per your requirement.
              print("Device added successfully");
            } else {
              // Error response, display an error message or handle it as needed.
              print("Failed to add device. Status Code: ${response.statusCode}");
              print("Response Body: ${response.body}");
            }
            Navigator.of(context).pop();

            // Close the dialog after handling the response.
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('add_device'.tr, style: TextStyle(fontSize: 20)),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'add_device'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'device_id'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _deviceController,
                decoration: InputDecoration(
                  hintText: 'enter_device_id'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'device_name'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _devicenameController,
                decoration: InputDecoration(
                  hintText: 'enter_device_name'.tr,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Text(
                'sim'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _simController,
                decoration: InputDecoration(
                  hintText: 'enter_device_sim'.tr,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'topic'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _topiccontroller,
                decoration: InputDecoration(
                  hintText: 'enter_topic'.tr,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Text(
                'device_serial-no'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _serialNocontroller,
                decoration: InputDecoration(
                  hintText: 'enter_serial_no'.tr,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
