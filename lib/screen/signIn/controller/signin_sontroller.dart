import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screen/utils/firebas.dart';

class SignInController extends GetxController{

  TextEditingController txtemail =TextEditingController();
  TextEditingController txtpass =TextEditingController();

  Future<String?> SingUp()
  async {
    String? msg = await FireBase.fireBase.singup(email: txtemail.text, password: txtpass.text);
    txtpass.clear();
    txtemail.clear();
    return msg;
  }

  Future<String?> SingIn()
  async {
    String? msg= await FireBase.fireBase.Login(email: txtemail.text, password: txtpass.text);
    txtpass.clear();
    txtemail.clear();
    return msg;
  }
}