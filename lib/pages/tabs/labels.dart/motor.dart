// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Motor extends StatefulWidget {
  final Map<String, dynamic>? motorLogs;

  Motor(this.motorLogs);

  @override
  State<Motor> createState() => _MotorState(motorLogs);
}

class _MotorState extends State<Motor> {
  final Map<String, dynamic>? motorLogs;

  _MotorState(this.motorLogs);

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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> logList =
        (motorLogs?['onOffLogDtos'] as List<dynamic>?)
                ?.map((dynamic item) =>
                    (item as Map<String, dynamic>) ?? <String, dynamic>{})
                .toList() ??
            [];
    final String powerValueForRollup = logList.isNotEmpty
        ? (logList[0]['difference']['valueForRollup'] as String? ?? "")
        : "";
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500),
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
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width *
                      0.2, // Adjust the height as needed for the first row
                  color: Color.fromARGB(
                      181, 51, 42, 55), // Background color for the first row
                  child: Center(
                      child: Text("on".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ))),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width *
                      0.3, // Adjust the height as needed for the first row
                  // Adjust the height as needed for the first row
                  color: Color.fromARGB(181, 51, 42, 55),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("off".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        )),
                  )),
                ),
                //  SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width *
                      0.4, // Adjust the height as needed for the first row
                  // Adjust the height as needed for the first row
                  color: Color.fromARGB(181, 51, 42, 55),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text("duration".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        )),
                  )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Table(
            border: TableBorder(
              horizontalInside: BorderSide(
                  color:
                      Colors.grey), // Border for horizontal lines inside cells
              // verticalInside: BorderSide(color: Colors.black),   // Border for vertical lines inside cells
              bottom: BorderSide(
                  color: Colors.grey), // Border for the bottom of the table
            ),
            columnWidths: {
              0: FixedColumnWidth(120),
              1: FixedColumnWidth(120),
              2: FixedColumnWidth(120),
            },
            children: [
              for (var item in logList)
                TableRow(children: [
                  SizedBox(
                      height: 30, child: Center(child: Text(item['onTime']))),
                  SizedBox(
                      height: 30, child: Center(child: Text(item['offTime']))),
                  SizedBox(
                      height: 30,
                      child: Center(
                          child: Text(
                              item['difference']['valueForRollup'] ?? ""))),
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
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(
                  'total_duration'.tr,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  ': ${motorLogs?['totalTime']}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
