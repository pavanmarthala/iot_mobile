// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Load extends StatefulWidget {
  

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> {
      bool isRefreshing = false;

   void handleRefresh() {
    setState(() {
      isRefreshing = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isRefreshing = false;
        });
      });
    });
  }
    void updateData(Map<String, dynamic> data) {
  // Update the data in the Power tab
  // Extract the ON, OFF, duration, and total duration data from 'data' and update your UI accordingly.
}
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.only(left: 40,right: 40),
        child: Row(
          children: [

                  SizedBox(width: 80,),
                 Text('refresh_logs'.tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                 SizedBox(width: 5),
                  isRefreshing
                   ? CircularProgressIndicator()
                  : Container(
                      height: 25,
                      width: 25,
                      child: GestureDetector(
                        onTap: handleRefresh,
                        child: Image.asset("assets/refresh.png",)
                      ),
                    ),
               ],
             ),
           ),
           SizedBox(height: 10,),
            Table(
      // border: TableBorder.all(color: Colors.black,),
      columnWidths: {
        0: FixedColumnWidth(180),
        1: FixedColumnWidth(180),
        // 2: FixedColumnWidth(120),
        
      },
      children: [
        TableRow(
      children: [
        Container(
          height: 50, // Adjust the height as needed for the first row
          color: Color.fromARGB(181, 51, 42, 55), // Background color for the first row
          child: Center(child: Text("current".tr, style: TextStyle(color: Colors.white,fontSize: 20,))),
        ),
        Container(
          height: 50, // Adjust the height as needed for the first row
          color: Color.fromARGB(181, 51, 42, 55),
          child: Center(child: Text("voltage".tr, style: TextStyle(color: Colors.white,fontSize: 20,))),
        ),
        // Container(
        //   height: 50, // Adjust the height as needed for the first row
        //   color: Color.fromARGB(181, 51, 42, 55),
        //   child: Center(child: Text("Duration", style: TextStyle(color: Colors.white,fontSize: 20,))),
        // ),
      ],
    ),
    TableRow(children: [
      SizedBox(
         height: 35,
        child: Center(child: Text("0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
        ),
      SizedBox(
         height: 35,

        child: Center(child: Text("0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
      // SizedBox(
        
      //    height: 30,
      //   child: Center(child: Text("- "))),
    ]),
    TableRow(children: [
      SizedBox(
         height: 30,
        child: Center(child: Text("0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
        ),
      SizedBox(
         height: 30,

        child: Center(child: Text("0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))),
      // SizedBox(
        
      //    height: 30,
      //   child: Center(child: Text("- "))),
    ]),
      ],
    ),
            

             SizedBox(height: 30,),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),
                  Padding(
        padding: const EdgeInsets.only(left: 40,right: 40),
        child: Row(
          children: [
                  SizedBox(width: 160,),
                 Text('total_records'.tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            Text(': 0',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

               ],
             ),
           ),
             
      ],
    );
  }
}