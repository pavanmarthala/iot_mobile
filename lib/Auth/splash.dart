// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:iot_mobile_app/Auth/singin.dart';




class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);



  @override

  _SplashScreenState createState() => _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen> {

  @override

  void initState() {

    super.initState();

    _nagivatetohome();

  }



  _nagivatetohome() async {

    await Future.delayed(const Duration(seconds:4), () {

      Navigator.push(context, MaterialPageRoute(builder: (context) => const SingIN()));

    });

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Image.asset('assets/splash_theja.png'), // Replace with your image path

      ),

    );

  }

}

