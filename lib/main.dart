import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/screen/home/view/home_view.dart';
import 'package:todo/screen/signIn/view/signin_screen.dart';
import 'package:todo/screen/signup/view/signup_screen.dart';
import 'package:todo/screen/splash/view/splash_screen.dart';
import 'package:todo/screen/task/view/task_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(Sizer(
    builder: (context, orientation, deviceType) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => SplashScreen(),transition: Transition.fade),
        GetPage(name: '/login', page: () => SignInScreen(),transition: Transition.leftToRightWithFade),
        GetPage(name: '/signup', page: () => SihnUpScreen(),transition: Transition.leftToRightWithFade),
        GetPage(name: '/home', page: () => HomeScreen(),transition: Transition.leftToRightWithFade),
        GetPage(name: '/task', page: () => TaskScreen(),transition: Transition.leftToRightWithFade),
      ],
    ),
  ));
}
