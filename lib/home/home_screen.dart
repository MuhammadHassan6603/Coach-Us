import 'package:didpool/home/meal_details.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       hintText: 'Search pancake',
                  //       suffixIcon: Image.asset(
                  //         "assets/Filter.png",
                  //         scale: 3.8,
                  //       ),
                  //       filled: true,
                  //       fillColor: Color(0xff141118),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         borderSide: BorderSide(
                  //           color: Color(0xff141118),
                  //         ),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //         borderSide: BorderSide(
                  //           color: Color(0xff141118),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  AppText(
                    'Category',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE9E3E4),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff243e3b),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Image.asset(
                                          "assets/breakfast 5.png",
                                          scale: 3.5,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      AppText(
                                        'Salad',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
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
                  AppText(
                    'Recommendations For Diet',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            IntrinsicHeight(
                              child: Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff243e3b),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Image.asset(
                                      "assets/dieta.png",
                                      scale: 4,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    AppText(
                                      'Honey Pancake',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffE9E3E4),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    AppText(
                                      'Easy | 30mins | 180kCal',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MealDetails()));
                                      },
                                      child: Container(
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xff0f856f),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                                          child: Center(
                                            child: AppText(
                                              'View',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            // Container(
                            //   height: 240.h,
                            //   width: 200.w,
                            //   decoration: BoxDecoration(
                            //     color: Color(0xff412b53),
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       SizedBox(
                            //         height: 20.h,
                            //       ),
                            //       Image.asset(
                            //         "assets/dieta.png",
                            //         scale: 4,
                            //       ),
                            //       SizedBox(
                            //         height: 15.h,
                            //       ),
                            //       AppText(
                            //         'Honey Pancake',
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.w600,
                            //         color: Color(0xffE9E3E4),
                            //       ),
                            //       SizedBox(
                            //         height: 5.h,
                            //       ),
                            //       AppText(
                            //         'Easy | 30mins | 180kCal',
                            //         fontSize: 10.sp,
                            //         fontWeight: FontWeight.w500,
                            //         color: Colors.grey,
                            //       ),
                            //       SizedBox(
                            //         height: 15.h,
                            //       ),
                            //       GestureDetector(
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       MealDetails()));
                            //         },
                            //         child: Container(
                            //           height: 30.h,
                            //           width: 100.w,
                            //           decoration: BoxDecoration(
                            //             color: Color(0xff0f856f),
                            //             borderRadius: BorderRadius.circular(15),
                            //           ),
                            //           child: Center(
                            //             child: AppText(
                            //               'View',
                            //               fontSize: 12.sp,
                            //               fontWeight: FontWeight.w500,
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 15.w,
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  AppText(
                    'Popular',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 2,
                    physics: NeverScrollableScrollPhysics(),
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
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff93289f))),
                            child: Image.asset(
                              "assets/arrow.png",
                              scale: 4.2,
                              color: Color(0xff93289f),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
