import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealSchedule extends StatefulWidget {
  const MealSchedule({super.key});

  @override
  State<MealSchedule> createState() => _MealScheduleState();
}

class _MealScheduleState extends State<MealSchedule> {
  DateTime? select = DateTime.now();
  DatePickerController controller = DatePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color(0xff5e2bd2),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/Stroke 1.png",
                      scale: 3.5,
                    ),
                  ),
                  SizedBox(
                    width: 75.w,
                  ),
                  AppText(
                    'Meal Schedule',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE9E3E4),
                  ),
                  Spacer(),
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Ellipse 81.png",
                          scale: 4,
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Image.asset(
                          "assets/Ellipse 81.png",
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: AppText(
                  "<   March 2025  >",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 100.h,
                child: DatePicker(
                  monthTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                  dateTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                  dayTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                  controller: DatePickerController(),
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Color(0xff9d26ba),
                  selectedTextColor: Colors.white,
                  onDateChange: (value) {
                    setState(() {
                      select = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  AppText(
                    'Breakfast',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Spacer(),
                  AppText(
                    '2 meals | 230 calories',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Color(0xff412b53),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/coffee.png",
                                scale: 3.8,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Chicken Steak',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE9E3E4),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AppText(
                                '01:00pm',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 19.h,
                            width: 19.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Image.asset(
                              "assets/arrow.png",
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  AppText(
                    'Lunch',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Spacer(),
                  AppText(
                    '2 meals | 500 calories',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Color(0xff412b53),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/coffee.png",
                                scale: 3.8,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Chicken Steak',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE9E3E4),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AppText(
                                '01:00pm',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 19.h,
                            width: 19.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Image.asset(
                              "assets/arrow.png",
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  AppText(
                    'Snacks',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Spacer(),
                  AppText(
                    '2 meals | 140 calories',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Color(0xff412b53),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/coffee.png",
                                scale: 3.8,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Chicken Steak',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE9E3E4),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AppText(
                                '01:00pm',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 19.h,
                            width: 19.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Image.asset(
                              "assets/arrow.png",
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  AppText(
                    'Dinner',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Spacer(),
                  AppText(
                    '2 meals | 120 calories',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: Color(0xff412b53),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/coffee.png",
                                scale: 3.8,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Chicken Steak',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE9E3E4),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AppText(
                                '01:00pm',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 19.h,
                            width: 19.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Image.asset(
                              "assets/arrow.png",
                              scale: 3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
