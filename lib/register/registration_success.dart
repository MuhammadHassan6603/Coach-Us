import 'package:didpool/profile_screen/profile.dart';
import 'package:didpool/bottom_bar/bottom_bar.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  "assets/Group (3).png",
                  scale: 4,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppText(
                  'Welcome User',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'You are all set now, let’s reach your goals together\nwith us',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Custombutton(
                    title: 'Go to Home',
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BottomBarScreen()));
                    }),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
