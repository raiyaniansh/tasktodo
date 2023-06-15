import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screen/home/modal/home_modal.dart';

class HomeController extends GetxController
{
  RxInt i=0.obs;
  RxInt day=0.obs;
  Rx<DateTime> date = DateTime.now().obs;
  TextEditingController txttask = TextEditingController();
  RxList<HomeModal> tasklist = <HomeModal>[].obs;

  RxBool up =false.obs;

  void updatedata()
  {
    up.value =!up.value;
  }

  void cheaktask()
  {
    i.value=0;
    for(int j =0; j< tasklist.length;j++)
    {
      if(tasklist[j].date=="${day.value}/${date.value.month}/${date.value.year}")
      {
        i++;
      }
      else
      {
        i=i;
      }
    }
  }

  void Dateadd()
  {
    day.value = day.value+1;
    print(day);
  }
}