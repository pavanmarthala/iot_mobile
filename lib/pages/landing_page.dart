// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:  Text("map_device".tr, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
           
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,),
              child: Container(
                width: 390,
                height: 150,
                decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
               child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50,top: 5),
                    child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                  ),
                    Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Image.asset("assets/power.png"),
                     )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/motor.jpeg")
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                    child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/on off.jpg")
                              ),
                  ),
                ),
              ],)
                ],
               ),
                     
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,),
              child: Container(
                width: 390,
                height: 150,
                decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
               child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50,top: 5),
                    child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                  ),
                    Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Image.asset("assets/power.png"),
                     )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/motor.jpeg")
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                    child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/on off.jpg")
                              ),
                  ),
                ),
              ],)
                ],
               ),
                     
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,),
              child: Container(
                width: 390,
                height: 150,
                decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
               child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50,top: 5),
                    child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                  ),
                    Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Image.asset("assets/power.png"),
                     )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/motor.jpeg")
                              ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,top: 5),
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                    child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("assets/on off.jpg")
                              ),
                  ),
                ),
              ],)
                ],
               ),
                     
              ),
            ),
            Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,),
            child: Container(
              width: 390,
              height: 150,
              decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 5),
                  child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                ),
                  Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.asset("assets/power.png"),
                   )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                 child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/motor.jpeg")
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/on off.jpg")
                            ),
                ),
              ),
            ],)
              ],
             ),
                   
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,),
            child: Container(
              width: 390,
              height: 150,
              decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 5),
                  child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                ),
                  Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.asset("assets/power.png"),
                   )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                 child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/motor.jpeg")
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/on off.jpg")
                            ),
                ),
              ),
            ],)
              ],
             ),
                   
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,),
            child: Container(
              width: 390,
              height: 150,
              decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 5),
                  child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                ),
                  Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.asset("assets/power.png"),
                   )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                 child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/motor.jpeg")
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/on off.jpg")
                            ),
                ),
              ),
            ],)
              ],
             ),
                   
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,),
            child: Container(
              width: 390,
              height: 150,
              decoration: BoxDecoration(color:Color.fromARGB(234, 203, 203, 203),borderRadius: BorderRadius.circular(20)),
             child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50,top: 5),
                  child: Text('Device ID:',style: TextStyle(fontSize: 25),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text('Device Name:',style: TextStyle(fontSize: 25),),
                ),
                  Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.asset("assets/power.png"),
                   )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                 child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/motor.jpeg")
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(30) ),
                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/on off.jpg")
                            ),
                ),
              ),
            ],)
              ],
             ),
                   
            ),
          ),
          ],
        ),
      ),
    );
  }
}