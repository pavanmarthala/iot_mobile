// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('mobile')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('text')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('Email')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('role')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('active')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('pin')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('language')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text("device id's")),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('zone')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('queue name')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 2.0, // Border width
                      style: BorderStyle
                          .solid, // Border style (you can use dotted or dashed too)
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (const Text('sub')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                        ),
                        child: Container(
                          width: 197,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 2.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (you can use dotted or dashed too)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6, top: 10),
                            child: (Text('texggggggggggggggggggggt')),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 2.0, // Border width
                          style: BorderStyle
                              .solid, // Border style (you can use dotted or dashed too)
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Center(
                                child: Text(
                              'user data',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (const Text('name')),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                  ),
                                  child: Container(
                                    width: 237,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (Text('texggggggggggggggggggggt')),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (const Text('first name')),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                  ),
                                  child: Container(
                                    width: 237,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (Text('texggggggggggggggggggggt')),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (const Text('last name')),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                  ),
                                  child: Container(
                                    width: 237,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 2.0, // Border width
                                        style: BorderStyle
                                            .solid, // Border style (you can use dotted or dashed too)
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
                                      child: (Text('texggggggggggggggggggggt')),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 2.0, // Border width
                                      style: BorderStyle
                                          .solid, // Border style (you can use dotted or dashed too)
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6, top: 10),
                                    child: (const Text('name')),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                ),
                                child: Container(
                                  width: 237,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 2.0, // Border width
                                      style: BorderStyle
                                          .solid, // Border style (you can use dotted or dashed too)
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6, top: 10),
                                    child: (Text('texggggggggggggggggggggt')),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
