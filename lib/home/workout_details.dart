import 'package:didpool/home/workout_Detalis3.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutDetails extends StatelessWidget {
  const WorkoutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9C23D7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
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
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 20),
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
                height: 15.h,
              ),
              Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/workout details.png",
                      scale: 4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Container(
                        height: 811.h,
                        width: double.infinity,
                        color: Color(0xff2a2c38),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                AppText(
                                  'Fullbody Workout',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                AppText(
                                  '11 Exercises | 32mins | 320 Calories Burn',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 53.h,
                                  width: 315.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xff243e3e),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/Calendar.png",
                                          scale: 3.5,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        AppText(
                                          'Schedule Workout',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                        Spacer(),
                                        AppText(
                                          '5/27, 09:00 AM',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Image.asset(
                                          "assets/arrow.png",
                                          scale: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                Container(
                                  height: 53.h,
                                  width: 315.w,
                                  decoration: BoxDecoration(
                                      color: Color(0xff412b51),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/up down.png",
                                          scale: 3.5,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        AppText(
                                          'Difficulity',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                        Spacer(),
                                        AppText(
                                          'Beginner',
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Image.asset(
                                          "assets/arrow.png",
                                          scale: 4,
                                        ),
                                      ],
                                    ),
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
                                      ' You’ll Need',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    Spacer(),
                                    AppText(
                                      '5 items',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 130.h,
                                              width: 130.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Image.asset(
                                                "assets/Layer 2.png",
                                                scale: 4,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            AppText(
                                              " Barbell",
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
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
                                      'Exercises',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    Spacer(),
                                    AppText(
                                      '3 Sets',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                AppText(
                                  ' Sets 1',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WorkoutDetalis3()));
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.asset(
                                                "assets/Vector-Exercises.png",
                                                scale: 3,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  'Warm Up',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffE9E3E4),
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                AppText(
                                                  '05:00',
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Image.asset(
                                                "assets/arrow.png",
                                                scale: 3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Custombutton(
                                  title: 'Start workout',
                                  ontap: () {},
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
