import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screen/utils/firebas.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 3), () async {
      User? user = await FireBase.fireBase.firebaseAuth.currentUser;
      if (user != null) {
        Get.offAndToNamed('/home');
      } else {
        Get.offAndToNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(
            "https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png",
            color: Colors.red,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
