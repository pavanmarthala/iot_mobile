// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../Home_page.dart';
import 'Add_user.dart';
import 'map_device.dart';

class MyDrawer extends StatefulWidget {
  // const MyDrawer({super.key});
const MyDrawer({Key? key, required this.onDeviceAdded, required this.deviceList})
      : super(key: key);
  // const MyDrawer({super.key});
 final Function(String) onDeviceAdded;
 final List<String> deviceList;
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // List<String> deviceList = [];
  List<Widget> buttons = [];
   

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Drawer(
         backgroundColor: Colors.white,
         
    
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                        
                  height: 180,
                  width: 60,
                   decoration: BoxDecoration(color: Colors.white,),
                    child: Image.asset("assets/logo.png")
                    //  Image.network('https://i.imgur.com/GzZgRzZ.png',),
            
              ),
            ),
            // SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Adduser(),),);

                },
                
                child: Row(
                  children: [
                     SizedBox(width: 60),
    
                     Icon(Icons.person_add,color: Colors.green),
                     SizedBox(width: 8),
                    Text('Add User',style: TextStyle(color: Colors.green),),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white.withOpacity(0.9),
                  onPrimary: Colors.black,
                  fixedSize: Size(150, 60),
                side: BorderSide(
                 color: Colors.green,
                 width:2,
                 style: BorderStyle.solid,
               ),
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                 ),
              ),
              ),
            ),
    
            SizedBox(height: 15,),
    
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: ElevatedButton(
                onPressed: () {
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Mapdevice(),),);

                },
                child: Row(
                  children: [
                     SizedBox(width: 60),
    
                    //  Icon(Icons.person_add,color: Colors.green),
                     SizedBox(width: 8),
                    Text('Map Device',style: TextStyle(color: Colors.green),),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  fixedSize: Size(150, 60),
                side: BorderSide(
                 color: Colors.green,
                 width:2,
                 style: BorderStyle.solid,
               ),
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                 ),
              ),
              ),
            ),
    
            
    

            
   
                for (var deviceName in widget.deviceList)
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25,top: 10),
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Homepage(),),);

                    // Handle button click for a specific device
                  },
                  child: Row(
                    children: [
                      Text(deviceName, style: TextStyle(color: const Color.fromARGB(255, 195, 51, 41), fontSize: 15),),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(223, 240, 200, 200),
                    fixedSize: Size(770, 60),
                    side: BorderSide(
                      color: Color.fromARGB(255, 218, 117, 110),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),


          // Add Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // When the Add Button is pressed, add a new button to the list
                _showAddDeviceDialog(context);
              },
              child: Text('Add Device'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  fixedSize: Size(150, 60),
                side: BorderSide(
                 color: Colors.green,
                 width:2,
                 style: BorderStyle.solid,
               ),
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                 ),
              ),
            ),
          ),
            // Dynamically generate device buttons

          ],
        ),
      ),
    );
  }

  void _showAddDeviceDialog(BuildContext context) {
    final _deviceController = TextEditingController();
    final _devicenameController = TextEditingController();
    final _pinController = TextEditingController();
    final _simController = TextEditingController();
    final _topiccontroller = TextEditingController();
    final _zonecontroller = TextEditingController();
    final _serialNocontroller = TextEditingController();
    final _mobileNocontroller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Builder(
          builder: (context) {
            return Scaffold(
              bottomNavigationBar:Container(
  width: double.infinity,
  // padding: EdgeInsets.all(16.0),
  child: ElevatedButton(
    onPressed: () {
      String deviceName = _devicenameController.text;
      // Add the new device name to the deviceList
      setState(() {
        widget.deviceList.add(deviceName);
      });
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 20),
    ),
    child: Text('Add Device', style: TextStyle(fontSize: 20)),
  ),
),


              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: const Text(
                  "Add Device",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        'Device Id',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _deviceController,
                        decoration: InputDecoration(
                          hintText: 'Enter device id',
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Device Name',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _devicenameController,
                        decoration: InputDecoration(
                          hintText: 'Enter Device Name',
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
                        'sim',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _simController,
                        decoration: InputDecoration(
                          hintText: 'Enter device sim',
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'topic',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _topiccontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter topic',
                        ),
                      ),
                      SizedBox(height: 20,),
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
                        'Device  serial Number',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextField(
                        controller: _serialNocontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter mobile serial number',
                        ),
                      ),
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
                      SizedBox(height: 90,),
                     
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}






