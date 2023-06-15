import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/screen/home/controller/home_controller.dart';
import 'package:todo/screen/home/modal/home_modal.dart';
import 'package:todo/screen/utils/firebas.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.primaryVelocity! > 0) {
                    setState(() {
                      controller.day - 1;
                    });
                    controller.cheaktask();
                  } else if (details.primaryVelocity! < 0) {
                    setState(() {
                      controller.day + 1;
                    });
                    controller.cheaktask();
                  }
                },
                child: Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Obx(
                        () => Text("Total Task - ${controller.i.value}",
                            style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${formatDate(DateTime(controller.date.value.year, controller.date.value.month, controller.day.value), [
                                      dd,
                                      " ",
                                      MM
                                    ])}",
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "${formatDate(DateTime(controller.date.value.year, controller.date.value.month, controller.day.value + 1), [
                                      dd,
                                      " ",
                                      M
                                    ]).toString().substring(0, 5)}",
                                style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
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
                      return Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.tasklist.length,
                          itemBuilder: (context, index) => Container(
                            child:
                                ("${controller.day.value}/${controller.date.value.month}/${controller.date.value.year}" ==
                                        controller.tasklist[index].date)
                                    ? GestureDetector(
                                        onDoubleTap: () {
                                          controller.txttask =
                                              TextEditingController(
                                                  text: controller
                                                      .tasklist[index].task);
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.black,
                                                insetPadding:
                                                    EdgeInsets.all(20),
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                shape: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .red.shade700),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                content: Container(
                                                  height: 40.h,
                                                  width: 90.w,
                                                  padding: EdgeInsets.all(15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        " Update the Task",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red.shade700,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      TextField(
                                                        controller: controller.txttask,
                                                        cursorColor:
                                                            Colors.white,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        decoration:
                                                            InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Text(
                                                        " Task Complate",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Obx(
                                                            () => InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .updatedata();
                                                              },
                                                              child: Container(
                                                                height: 5.w,
                                                                width: 5.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: (controller.up ==
                                                                          true)
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .updatedata();
                                                              },
                                                              child: Text(
                                                                  "Complate",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15.sp))),
                                                          Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Obx(
                                                            () => InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .updatedata();
                                                              },
                                                              child: Container(
                                                                height: 5.w,
                                                                width: 5.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: (controller.up ==
                                                                          false)
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .updatedata();
                                                              },
                                                              child: Text(
                                                                  "Uncomplate",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15.sp))),
                                                        ],
                                                      ),
                                                      Expanded(
                                                          child: SizedBox()),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            FloatingActionButton(
                                                                onPressed:
                                                                    () async {
                                                                  String msg = await FireBase.fireBase.Delettask(controller.tasklist[index].key);
                                                                  if(msg=="Success")
                                                                    {
                                                                      controller.cheaktask();
                                                                      Get.back();
                                                                    }
                                                                },
                                                                backgroundColor:
                                                                Colors.red
                                                                    .shade700,
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 25.sp,
                                                                )),
                                                            Expanded(
                                                                child: SizedBox()),
                                                            FloatingActionButton(
                                                                onPressed:
                                                                    () async {
                                                                  String msg =
                                                                      await FireBase
                                                                          .fireBase
                                                                          .UpdateTask(
                                                                    controller
                                                                        .txttask
                                                                        .text,
                                                                    "${controller.day.value}/${controller.date.value.month}/${controller.date.value.year}",
                                                                    (controller.up.value ==
                                                                            true)
                                                                        ? "true"
                                                                        : "false",
                                                                    controller
                                                                        .tasklist[
                                                                            index]
                                                                        .key,
                                                                  );
                                                                  if (msg ==
                                                                      "Success") {
                                                                    controller
                                                                        .cheaktask();
                                                                    Get.back();
                                                                    controller
                                                                        .txttask
                                                                        .clear();
                                                                  }
                                                                },
                                                                backgroundColor:
                                                                    Colors.red
                                                                        .shade700,
                                                                child: Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 25.sp,
                                                                )),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            FloatingActionButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  controller
                                                                      .txttask
                                                                      .clear();
                                                                },
                                                                child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red
                                                                        .shade700,
                                                                    size:
                                                                        25.sp),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white),
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
                                        onPanUpdate: (details) {
                                          if (details.delta.dx > 0) {
                                            FireBase.fireBase.UpdateTask(
                                                controller.tasklist[index].task,
                                                controller.tasklist[index].date,
                                                "true",
                                                controller.tasklist[index].key);
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                              "${controller.tasklist[index].task}",
                                              style: TextStyle(
                                                  color: (controller
                                                              .tasklist[index]
                                                              .com ==
                                                          "true")
                                                      ? Colors.white60
                                                      : Colors.white,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w600,
                                                  decoration: (controller
                                                              .tasklist[index]
                                                              .com ==
                                                          "true")
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                                  decorationColor: Colors.red,
                                                  decorationThickness: 1.5.sp)),
                                        ),
                                      )
                                    : Container(),
                          ),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                  stream: FireBase.fireBase.readTask()),
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
                                                  "${controller.day.value}/${controller.date.value.month}/${controller.date.value.year}",
                                                  "false");
                                          if (msg == "Success") {
                                            controller.cheaktask();
                                            Get.back();
                                            controller.txttask.clear();
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
                heroTag: "add",
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
                  Get.back();
                  controller.txttask.clear();
                  controller.day.value = controller.date.value.day;
                },
                heroTag: "close",
                child:
                    Icon(Icons.close, color: Colors.red.shade700, size: 25.sp),
                backgroundColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
