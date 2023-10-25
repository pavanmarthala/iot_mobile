// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';
import 'package:iot_mobile_app/pages/settings/select_device.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';

class Limits extends StatefulWidget {
  const Limits({super.key});

  @override
  State<Limits> createState() => _LimitsState();
}

class _LimitsState extends State<Limits> {
  final _minimumVoltageController = TextEditingController();
  final _maximumVoltageController = TextEditingController();
  final _minimumCurrentController = TextEditingController();
  final _maximumCurrentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Settings(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('save_device_list'.tr, style: TextStyle(fontSize: 20)),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "set_limits".tr,
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
              Text(
                'device'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),

              TextField(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectDevice(),
                    ),
                  );
                },
                // controller: _minimumVoltageController,
                decoration: InputDecoration(
                  hintText: 'Select Device'.tr,
                ),
              ),
              // DropdownButton<String>(
              //   value: 'Device 1',
              //   items: const [
              //     DropdownMenuItem(value: 'Device 1', child: Text('Device ')),
              //     DropdownMenuItem(value: 'Device 2', child: Text('Device 2')),
              //     DropdownMenuItem(value: 'Device 3', child: Text('Device 3')),
              //   ],
              //   onChanged: (value) {},
              //   style: TextStyle(
              //     // Customize the text style of the selected item
              //     color: Colors.black,
              //     fontSize: 16,
              //   ),
              //   elevation: 4, // Dropdown elevation
              //   // icon: Icon(Icons.arrow_downward), // Dropdown icon
              //   iconSize: 4, // Icon size
              //   isDense: false, // Reduce the padding around the text
              //   isExpanded: true, // Expand the button to fill available width
              //   // underline: Container(
              //   //   // Customize the underline
              //   //   height: 2,
              //   //   color: Colors.blue,
              //   // ),
              // ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'minimum_voltage'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _minimumVoltageController,
                decoration: InputDecoration(
                  hintText: 'enter_minimum_voltage'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'maximum_voltage'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _maximumVoltageController,
                decoration: InputDecoration(
                  hintText: 'enter_maximum_voltage'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'minimum_current'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _minimumCurrentController,
                decoration: InputDecoration(
                  hintText: 'enter_minimum_current'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'maximum_current'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _maximumCurrentController,
                decoration: InputDecoration(
                  hintText: 'enter_maximum_current'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
