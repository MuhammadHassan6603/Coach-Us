import 'package:didpool/home/home_screen.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MealPlanner extends StatelessWidget {
  const MealPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Planner',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      'Meal Nutritions',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffE9E3E4),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Spacer(),
                    Container(
                      height: 30.h,
                      width: 76.w,
                      decoration: BoxDecoration(
                        color: Color(0xff4023D7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          AppText(
                            'Weekly',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Image.asset(
                            "assets/bottom.png",
                            scale: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Container(
                    height: 57.h,
                    width: 315.w,
                    decoration: BoxDecoration(
                        color: Color(0xff412a51),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          AppText(
                            'Daily Workout Schedule',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffE9E3E4),
                          ),
                          Spacer(),
                          Container(
                            height: 28.h,
                            width: 68.w,
                            decoration: BoxDecoration(
                              color: Color(0xff4023D7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: AppText(
                                'Check',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffE9E3E4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                Row(
                  children: [
                    AppText(
                      'Today Meals',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffE9E3E4),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Container(
                        height: 30.h,
                        width: 87.w,
                        decoration: BoxDecoration(
                          color: Color(0xff0f8752),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            AppText(
                              'Breakfast',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              "assets/bottom.png",
                              scale: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.asset(
                          "assets/todays.png",
                          scale: 3.5,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Salmon Nigiri',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffE9E3E4),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            AppText(
                              'Today | 7am',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Color(0xff352b46),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Image.asset(
                            "assets/notification3.png",
                            scale: 3.3,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppText(
                  'Find Something to Eat',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffE9E3E4),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Color(0xff253e3d),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(90),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Image.asset(
                                        "assets/baker.png",
                                        scale: 3.8,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                AppText(
                                  'Breakfast',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffE9E3E4),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                AppText(
                                  '120+ Foods',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  height: 30.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0f856f),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      'Select',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
