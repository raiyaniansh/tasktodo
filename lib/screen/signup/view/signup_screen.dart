import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/screen/signIn/controller/signin_sontroller.dart';
import 'package:todo/screen/utils/firebas.dart';

class SihnUpScreen extends StatefulWidget {
  const SihnUpScreen({Key? key}) : super(key: key);

  @override
  State<SihnUpScreen> createState() => _SihnUpScreenState();
}

class _SihnUpScreenState extends State<SihnUpScreen> {
  SignInController controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "SingIn",
                      style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    "SingUp",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 25.w),
                  width: 30.w,
                  height: 10.h,
                  child: Image.network(
                    "https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png",
                    color: Colors.red,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 15.h,
              ),
              TextField(
                controller: controller.txtemail,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  label: Text("Email", style: TextStyle(color: Colors.red)),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextField(
                controller: controller.txtpass,
                obscureText: true,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  label: Text("Password", style: TextStyle(color: Colors.red)),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      String? msg = await controller.SingUp();
                      if (msg == "success") {
                        Get.offAndToNamed('/home');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("$msg")));
                      }
                    },
                    child: Container(
                      height: 7.h,
                      width: 7.h,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          shape: BoxShape.circle
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 20.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26.h,
              ),
              InkWell(
                onTap: () async {
                  String msg = await FireBase.fireBase.signInWithGoogle();
                  if (msg == "success") {
                    Get.offAndToNamed('/home');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 7.h,
                        width: 7.h,
                        alignment: Alignment.center,
                        child: Image.network(
                            'https://i.pinimg.com/originals/9a/95/6d/9a956dacd19ccd12df9fccdbd44d8bb6.jpg')),
                    Text("Login with google",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
