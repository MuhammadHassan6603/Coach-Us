import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutDetalis3 extends StatelessWidget {
  const WorkoutDetalis3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 20.h,
                ),
                Image.asset(
                  "assets/Video-Section.png",
                  scale: 3,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppText(
                  'Jumping Jack',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE9E3E4),
                ),
                AppText(
                  'Easy | 390 Calories Burn',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppText(
                  "Descriptions",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE9E3E4),
                ),
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
                  height: 30.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      ' How To Do It',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    Spacer(),
                    AppText(
                      '4 Steps',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppText(
                      '01',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        AppText(
                          ' Spread Your Arms',
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
                ),
                Row(
                  children: [
                    AppText(
                      '02',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        AppText(
                          ' Rest at The Toe',
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
                ),
                Row(
                  children: [
                    AppText(
                      '03',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        AppText(
                          ' Adjust Foot Movement',
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
                ),
                Row(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  "assets/timer picker.png",
                  scale: 3,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Custombutton(
                  title: 'Save',
                  ontap: () {},
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
