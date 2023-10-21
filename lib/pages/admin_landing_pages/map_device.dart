// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/lang_page.dart';

class Mapdevice extends StatefulWidget {
  const Mapdevice({super.key});

  @override
  State<Mapdevice> createState() => _LimitsState();
}

class _LimitsState extends State<Mapdevice> {
  final _userController = TextEditingController();
  final _deviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        // padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text('map_user_to_device'.tr, style: TextStyle(fontSize: 20)),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "map_user_to_device".tr,
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
                'user_id'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  hintText: 'enter_user_id'.tr,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
