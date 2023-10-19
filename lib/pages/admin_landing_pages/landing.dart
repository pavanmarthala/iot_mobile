import 'package:flutter/material.dart';
// import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/manage_device.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/map_devices.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/manage_user.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';

 

class Adminlandingpage extends StatefulWidget {

  const Adminlandingpage({Key? key}) : super(key: key);

 

  @override

  State<Adminlandingpage> createState() => _AdminlandingpageState();

}

 

class _AdminlandingpageState extends State<Adminlandingpage> {

  @override

  Widget build(BuildContext context) {

    return  Scaffold(

        appBar: AppBar(

          title: Text('Manage Users'),
automaticallyImplyLeading: false, 

          backgroundColor: Colors.green,

        ),

        body: Center(

          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
          
              // mainAxisAlignment: MainAxisAlignment.center,
          
              children: [
          
                Container(
          
                  width: 350,
          
                  height: 120,
          
                  padding: EdgeInsets.all(10),
          
                  child: ElevatedButton(
          
                    onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Users(),),);
          
                      // Provide a valid function for the button
          
                    },
          
                    style: ElevatedButton.styleFrom(
          
                      primary: Colors.grey,
          
                      shape: RoundedRectangleBorder(
          
                        borderRadius: BorderRadius.circular(25),
          
                      ),
          
                    ),
          
                    child: Text(
          
                      'Manage Users',
          
                      style: TextStyle(fontSize: 25,color: Colors.black),
          
                    ),
          
                  ),
          
                ),
          
               // SizedBox(height: 10),
          
                Container(
          
                  width: 350,
          
                  height: 120,
          
                  padding: EdgeInsets.all(10),
          
                  child: ElevatedButton(
          
                    onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Managedevice(),),);

          
                      // Provide a valid function for the button
          
                    },
          
                    style: ElevatedButton.styleFrom(
          
                      primary: Colors.grey,
          
                      shape: RoundedRectangleBorder(
          
                        borderRadius: BorderRadius.circular(25),
          
                      ),
          
                    ),
          
                    child: Text(
          
                      'Manage Devices',
          
                      style: TextStyle(fontSize: 25,color: Colors.black),
          
                    ),
          
                  ),
          
                ),
          
               // SizedBox(height: 10),
          
                Container(
          
                  width: 350,
          
                  height: 120,
          
                  padding: EdgeInsets.all(10),
          
                  child: ElevatedButton(
          
                    onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Mapdevices(),),);
          
                      // Provide a valid function for the button
          
                    },
          
                    style: ElevatedButton.styleFrom(
          
                      primary: Colors.grey,
          
                      shape: RoundedRectangleBorder(
          
                        borderRadius: BorderRadius.circular(25),
          
                      ),
          
                    ),
          
                    child: Text(
          
                      'Map a Device',
          
                      style: TextStyle(color: Colors.black,fontSize: 25),
          
                    ),
          
                  ),
          
                ),
          
               // SizedBox(height: 10),
          
                Container(
          
                  width: 350,
          
                  height: 120,
          
                  padding: EdgeInsets.all(10),
          
                  child: ElevatedButton(
          
                    onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Landingpage(),),);

          
                      // Provide a valid function for the button
          
                    },
          
                    style: ElevatedButton.styleFrom(
          
                      primary: Colors.grey,
          
                      shape: RoundedRectangleBorder(
          
                        borderRadius: BorderRadius.circular(25),
          
                      ),
          
                    ),
          
                    child: Text(
          
                      'View Mapped Devices',
          
                      style: TextStyle(color: Colors.black,fontSize: 25),
          
                    ),
          
                  ),
          
                ),
          
              ],
          
            ),
          ),

        ),

      );

 

  }

}