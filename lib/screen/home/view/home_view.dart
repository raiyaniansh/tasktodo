import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/screen/home/controller/home_controller.dart';
import 'package:todo/screen/home/modal/home_modal.dart';
import 'package:todo/screen/utils/firebas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      controller.day.value = controller.date.value.day;
      controller.cheaktask();
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  "Calendar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Obx(
                () => TableCalendar(
                  firstDay: DateTime.utc(DateTime.now().year - 1,
                      DateTime.now().month - 12, DateTime.now().day - 10),
                  lastDay: DateTime.utc(DateTime.now().year + 1,
                      DateTime.now().month + 12, DateTime.now().day + 10),
                  focusedDay: controller.date.value,
                  currentDay: controller.date.value,
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.date.value = focusedDay;
                    controller.day.value = controller.date.value.day;
                    controller.cheaktask();
                  },
                  headerStyle: HeaderStyle(
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 35.sp),
                      headerPadding: EdgeInsets.only(left: 4.w, bottom: 2.h)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white),
                      weekendStyle: TextStyle(color: Colors.white)),
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.red.shade700, shape: BoxShape.circle),
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      outsideDaysVisible: false),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Container(
                height: 33.h,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 18),
                alignment: Alignment.topLeft,
                child: StreamBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        controller.tasklist.value = [];
                        var data = snapshot.data!.docs;
                        for (var x in data) {
                          HomeModal m1 = HomeModal(
                              com: x['com'],
                              date: x['date'],
                              task: x['task'],
                              key: x.id);
                          controller.tasklist.add(m1);
                        }
                        return Obx(
                          () => Container(
                            child: controller.i.value == 0
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Task",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 35.sp),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                        width: 1.5.h,
                                        height: 1.5.h,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.day.value =
                                              controller.date.value.day;
                                          Get.toNamed('/task');
                                        },
                                        child: Text(
                                          "${controller.i} Task",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                          width: 1.5.h,
                                          height: 1.5.h,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle)),
                                    ],
                                  ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                    stream: FireBase.fireBase.readTask()),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
                onPressed: () {
                  controller.txttask.clear();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        insetPadding: EdgeInsets.all(20),
                        contentPadding: EdgeInsets.all(0),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red.shade700),
                            borderRadius: BorderRadius.circular(15)),
                        content: Container(
                          height: 30.h,
                          width: 90.w,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " Enter the Task",
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextField(
                                cursorColor: Colors.white,
                                controller: controller.txttask,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FloatingActionButton(
                                        onPressed: () async {
                                          String msg = await FireBase.fireBase
                                              .AddTask(
                                                  controller.txttask.text,
                                                  "${controller.date.value.day}/${controller.date.value.month}/${controller.date.value.year}",
                                                  "false");
                                          if (msg == "Success") {
                                            controller.day.value =
                                                controller.date.value.day;
                                            controller.cheaktask();
                                            controller.txttask.clear();
                                            Get.back();
                                          }
                                        },
                                        backgroundColor: Colors.red.shade700,
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 25.sp,
                                        )),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    FloatingActionButton(
                                        onPressed: () {
                                          Get.back();
                                          controller.txttask.clear();
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.red.shade700,
                                            size: 25.sp),
                                        backgroundColor: Colors.white),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                heroTag: "1",
                backgroundColor: Colors.red.shade700,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25.sp,
                )),
            SizedBox(
              width: 2.w,
            ),
            FloatingActionButton(
                onPressed: () {
                  FireBase.fireBase.SignOut();
                  Get.offAndToNamed('/login');
                },
                heroTag: "0",
                child:
                    Icon(Icons.logout, color: Colors.red.shade700, size: 25.sp),
                backgroundColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
