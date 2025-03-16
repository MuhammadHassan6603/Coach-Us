import 'package:didpool/components/app_color.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/onboarding/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/boday3.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 70.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Track your Goal',
                    fontSize: 24.sp,
                    color: AppColor.whitecolor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Explore a wide range of religious tourism packages \nfrom trusted agents. Filter by date, price, location, or \nspecific needs to find the perfect match for your \nspiritual journey.',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Onboarding3()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Color(0xff7531cf),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 5),
                            child: Container(
                              height: 70.h,
                              width: 70.w,
                              decoration: BoxDecoration(
                                  color: Color(0xff7531cf),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                "assets/Arrow - Right 2.png",
                                scale: 3,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
