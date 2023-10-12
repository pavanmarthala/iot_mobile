// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/singin.dart';
import 'Set_limits.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Widget customListTile({  required String title, required IconData iconData, }) {
    return ListTile(
      
      title: Text(title,style: const TextStyle(color:Colors.white54),),
      trailing: Icon(
        iconData,
        size: 32,

      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //  drawer: Drawer(),
       appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
         title:  Text("settings".tr, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
        
       ),

       body: ListView(
        children: [
          Row(  
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50,left: 60),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(100, 22, 44, 43),
                    backgroundImage: NetworkImage("https://p7.hiclipart.com/preview/782/114/405/5bbc3519d674c.jpg"),
                    // radius: 40,
                ),   
              ),
              SizedBox(width: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 50,),

                child: Text("welcome".tr,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(" Teja Karimireddy",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 350,
                  decoration: BoxDecoration(
                  color: Color.fromARGB(255, 222, 220, 220),
                  borderRadius: BorderRadius.circular(10)

                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text('sub'.tr,style: TextStyle(fontSize: 17),),
                        SizedBox(width: 65,),
                        Text('2023/09/31',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15))
                  
                  
                      ],
                    ),
                  ) ,
                  
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Divider(
          height: 2,
          color: Colors.grey,
        ),
          SizedBox(height: 10,),


         ListTile(
              title:  Text('renew_sub'.tr,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
              trailing: const Icon(Icons.refresh_outlined,color: Colors.black,),


              onTap: () {

              },
            ),
          SizedBox(height: 10,),

             Container(
               
                       height: 1,
                       color: Colors.grey,
                     
             ),
          SizedBox(height: 10,),

        ListTile(
              title:  Text("set_limits".tr,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
              trailing: const Icon(Icons.code,color: Colors.black),


              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Limits(),),);
        
              },
            ),
          SizedBox(height: 10,),

            Container(
               
                       height: 1,
                       color: Colors.grey,
                     
             ),
          SizedBox(height: 10,),

             ListTile(
              title:  Text("notifications".tr,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
              trailing: const Icon(Icons.notifications,color: Colors.black),


              onTap: () {

              },
            ),
          SizedBox(height: 10,),

            Container( 
                       height: 1,
                       color: Colors.grey,
                     
             ),
          SizedBox(height: 10,),

             ListTile(
              title:  Text("sign_out".tr,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
              trailing: const Icon(Icons.exit_to_app_outlined,color: Colors.black),


              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SingIN(),),);
                                                        
              },
            ),
          SizedBox(height: 10,),

            Container(
               
                       height: 1,
                       color: Colors.grey,
                     
             ),
          SizedBox(height: 10,),


        ],
       ),
    );
  }
}