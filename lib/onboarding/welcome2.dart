import 'package:didpool/components/custom_button.dart';
import 'package:didpool/onboarding/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome2 extends StatefulWidget {
  const Welcome2({super.key});

  @override
  State<Welcome2> createState() => _Welcome1State();
}

class _Welcome1State extends State<Welcome2> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d29a8),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 360.h,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'DIDPOOL',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'FIT',
                      style: TextStyle(
                          color: Color(0xff986df1),
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Everyone can train",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 250.h,
            ),
            Custombutton(
                title: 'get started',
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Onboarding1()));
                })
          ],
        ),
      ),
    );
  }
}
