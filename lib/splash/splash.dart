import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:didpool/bottom_bar/bottom_bar.dart';
import 'package:didpool/onboarding/onboarding1.dart';
import 'package:didpool/register/complete_profile.dart';
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
    Future.delayed(Duration(seconds: 2), () {
      _handleNavigation();
    });
  }

  void _handleNavigation() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onboarding1()));
    } else {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists && userDoc['profileCompleted'] == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomBarScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CompleteProfile()));
      }
    }
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
                SizedBox(height: 300.h),
                Image.asset('assets/icons/logo.png', width: 90, height: 90),
                Center(
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(seconds: 2),
                    style: GoogleFonts.poppins(
                      color:
                          _changeBackground ? Colors.white : Color(0xff986df1),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text('Coach US'),
                  ),
                ),
                SizedBox(height: 2.h),
                AnimatedDefaultTextStyle(
                  duration: Duration(seconds: 2),
                  style: GoogleFonts.poppins(
                    color: _changeBackground ? Colors.black87 : Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  child: Text("Everyone Can Train"),
                ),
                SizedBox(height: 300.h),
                // Custombutton(
                //     title: 'Get Started',
                //     ontap: () {
                //       _handleNavigation();
                //     }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
