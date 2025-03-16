import 'dart:async';
import 'package:didpool/components/custom_button.dart';
import 'package:didpool/onboarding/onboarding1.dart';
import 'package:didpool/onboarding/welcome2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _changeBackground = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _changeBackground = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: _changeBackground
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 163, 115, 189),
                    Color.fromARGB(255, 112, 96, 194)
                  ],
                )
              : BoxDecoration(color: Color(0xff2A2C38)).gradient,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 360.h),
                Center(
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(seconds: 2),
                    style: GoogleFonts.poppins(
                      color: _changeBackground ? Colors.white : Color(0xff986df1),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text('Coach US'),
                  ),
                ),
                SizedBox(height: 6.h),
                AnimatedDefaultTextStyle(
                  duration: Duration(seconds: 2),
                  style: GoogleFonts.poppins(
                    color: _changeBackground ? Colors.black87 : Colors.grey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Text("Everyone Can Train"),
                ),
                SizedBox(height: 250.h),
                Custombutton(title: 'Get Started', ontap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding1()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
