// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
       bottomNavigationBar:SizedBox(
  width: double.infinity,
  // padding: EdgeInsets.all(16.0),
  child: ElevatedButton(
    onPressed: () {
    
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 20),
    ),
    child: Text('map_user_to_device'.tr, style: TextStyle(fontSize: 20)),
  ),
),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,      
         title:  Text("map_user_to_device".tr, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            
             
             SizedBox(height: 20,),
              Text(
                'user_id'.tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                  hintText: 'enter_user_id'.tr,
                ),
              ),
             SizedBox(height: 20,),

              Text(
                'device_id'.tr,
                style: Theme.of(context).textTheme.titleLarge,
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