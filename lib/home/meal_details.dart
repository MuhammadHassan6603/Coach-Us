import 'package:didpool/home/meal_schedule.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key});

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
                      "assets/meal details.png",
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40.h,
                                ),
                                AppText(
                                  'Blueberry Pancake',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'by',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: ' Arash Ranjbaran Qadikolaei',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                SizedBox(
                                  height: 30.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                            height: 38.h,
                                            width: 84.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xff253f3d),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/hot.png",
                                                    scale: 4.2,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppText('180kCal',
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Container(
                                            height: 38.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xff253f3d),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/Fat-Icon.png",
                                                    scale: 4.2,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppText('30g fats',
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Container(
                                            height: 38.h,
                                            width: 110.w,
                                            decoration: BoxDecoration(
                                                color: Color(0xff253f3d),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/Proteins-Icon.png",
                                                    scale: 4.2,
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  AppText('20g proteins',
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                AppText("Descriptions",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                SizedBox(
                                  height: 10.h,
                                ),
                                AppText(
                                  maxLines: 4,
                                  'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide  Read More...',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    AppText("Ingredients That You \nWill Need",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    Spacer(),
                                    AppText(
                                      '6items',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 80.h,
                                              width: 80.w,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.asset(
                                                "assets/flour.png",
                                                scale: 3,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            AppText(
                                              " Wheat Flour \n100gr",
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
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    AppText(
                                      'Step by Step',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    Spacer(),
                                    AppText(
                                      '8 Steps',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        AppText(
                                          '04',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffC050F6),
                                        ),
                                        SizedBox(
                                          width: 13.w,
                                        ),
                                        Image.asset(
                                          "assets/Circle-2.png",
                                          scale: 3.3,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                            ),
                                            AppText(
                                              ' Clapping Both Hands',
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            AppText(
                                              'To make the gestures feel more relaxed, \nstretch your arms as you start this \nmovement. No bending of hands.',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Center(
                                  child: Custombutton(
                                    title: 'Add to Breakfast Meal',
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MealSchedule()));
                                    },
                                  ),
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
