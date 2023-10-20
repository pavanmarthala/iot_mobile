// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Load extends StatefulWidget {
  final Map<String, dynamic>? loadLogs;

  Load(this.loadLogs);
  @override
  State<Load> createState() => _LoadState(loadLogs);
}

class _LoadState extends State<Load> {
  final Map<String, dynamic>? loadLogs;

  _LoadState(this.loadLogs);
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
    final String avgCurrent = loadLogs?['avgCurrent'] ?? "0";
    final String avgVoltage = loadLogs?['avgVoltage'] ?? "0";
    final String totalRecords = loadLogs?['totalRecords'] ?? "0";

    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              SizedBox(
                width: 80,
              ),
              Text(
                'refresh_logs'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 5),
              isRefreshing
                  ? CircularProgressIndicator()
                  : Container(
                      height: 25,
                      width: 25,
                      child: GestureDetector(
                          onTap: handleRefresh,
                          child: Image.asset(
                            "assets/refresh.png",
                          )),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 170, // Adjust the height as needed for the first row
                color: Color.fromARGB(
                    181, 51, 42, 55), // Background color for the first row
                child: Center(
                    child: Text("current".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))),
              ),
              Container(
                height: 50,
                width: 170, // Adjust the height as needed for the first row
                color: Color.fromARGB(181, 51, 42, 55),
                child: Center(
                    child: Text("voltage".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ))),
              ),
              // Container(
              //   height: 50, // Adjust the height as needed for the first row
              //   color: Color.fromARGB(181, 51, 42, 55),
              //   child: Center(child: Text("Duration", style: TextStyle(color: Colors.white,fontSize: 20,))),
              // ),
            ],
          ),
        ),
        Table(
          // border: TableBorder.all(color: Colors.black,),
          border: TableBorder(
            horizontalInside: BorderSide(
                color: Colors.grey), // Border for horizontal lines inside cells
            // verticalInside: BorderSide(color: Colors.black),   // Border for vertical lines inside cells
            bottom: BorderSide(
                color: Colors.grey), // Border for the bottom of the table
          ),
          columnWidths: {
            0: FixedColumnWidth(180),
            1: FixedColumnWidth(180),
            // 2: FixedColumnWidth(120),
          },
          children: [
            TableRow(children: [
              SizedBox(
                  height: 30,
                  child: Center(
                      child: Text(
                    avgCurrent,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))),
              SizedBox(
                  height: 30,
                  child: Center(
                      child: Text(
                    avgVoltage,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ))),
            ]),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              SizedBox(
                width: 150,
              ),
              Text(
                'total_records'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                ': $totalRecords',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
