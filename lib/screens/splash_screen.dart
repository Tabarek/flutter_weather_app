import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather/screens/home_screen.dart';
import 'package:weather/utils/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          elevation: 0.0,
        ),
        body: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(color: Colors.blue.shade200),
          child: Center(
            child: Image.asset(hotImg),
          ),
        ));
  }
}
