import 'package:didpool/components/app_color.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/register/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Track your Goal",
      "description":
          "Explore a wide range of tourism packages from trusted agents. Filter by date, price, location, or specific needs.",
    },
    {
      "title": "Get Burn",
      "description":
          "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
    },
    {
      "title": "Eat Well",
      "description":
          "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignupScreen()));
    }
  }

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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppText(
                onboardingData[currentIndex]["title"]!,
                fontSize: 24.sp,
                color: AppColor.whitecolor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                onboardingData[currentIndex]["description"]!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 70.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: nextPage,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: CircularProgressIndicator(
                        value: (currentIndex + 1) /
                            onboardingData.length,
                        strokeWidth: 4,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xff7531cf)),
                        backgroundColor: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff7531cf),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/Arrow - Right 2.png",
                          scale: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
