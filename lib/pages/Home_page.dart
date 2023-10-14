// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/pages/settings.dart';
import 'package:iot_mobile_app/pages/tabs/Logs.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Drawer/Drawer.dart';
import 'lang_page.dart';

// import 'package:iot_console/pages/tabs/status.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index =0;
   final screens = [
   Dash(),
   Logs(),
   ];


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
       backgroundColor: const Color(0xffcbcbcb),
       drawer: MyDrawer(onDeviceAdded: (String ) {  }, deviceList: [],),
       appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
         title:  Text("dashboard".tr, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
         actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0,),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Langscreen(),),);
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.green,
                // backgroundImage: AssetImage('assets/language-icon.png'), 
                child: SvgPicture.asset(
  'assets/language-icon.svg',
  // width: 100.0, // Adjust the width as needed
  // height: 100.0, // Adjust the height as needed
),

              ),
            ),
          ),
           Padding(
             padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 20.0),
             child: CircleAvatar(
               radius: 16,
               backgroundColor: Colors.green,
               child: IconButton(onPressed: () { Navigator.of(context).push(
                 MaterialPageRoute(builder: (context) =>Settings(),),); }, icon: Icon(Icons.settings, size: 30,color: Colors.black,)),
             ),
           ),
         ],
       ),
       body: screens[index],
       bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 14,fontWeight: FontWeight.w500))
        ),
         child: NavigationBar(
          height: 60,
          backgroundColor:Colors.green ,
             selectedIndex: index,
          onDestinationSelected: (index) => 
          setState(() => this.index = index),

          destinations: [
          NavigationDestination(
            icon:Icon(Icons.signal_cellular_alt_outlined, ),
            // selectedIcon:Icon(Icons.signal_cellular_alt_outlined, ) ,
             label:'status'.tr),
       
               NavigationDestination(
            icon:Icon(Icons.format_list_bulleted),
             label:'logs'.tr)
         ]),
       ),
      
    );
  }
}


