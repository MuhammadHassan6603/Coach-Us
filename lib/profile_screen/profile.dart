import 'package:didpool/home/worker_tracker.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool button = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(
                        "assets/best (2).png",
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Masi Ramezanzade',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffE9E3E4),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppText(
                          'Lose a Fat Program',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffB6B4C1),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      height: 30.h,
                      width: 83.w,
                      decoration: BoxDecoration(
                        color: Color(0xff4023D7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: AppText(
                          'Edit',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        AppText(
                          '180cm',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffC050F6),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        AppText(
                          'Height',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Column(
                      children: [
                        AppText(
                          '65Kg',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffC050F6),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        AppText(
                          'Weight',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                    Column(
                      children: [
                        AppText(
                          '22Yo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffC050F6),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        AppText(
                          'age',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 44.h,
                ),
                AppText(
                  '    Account',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/personal.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Personal Data',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/achivement.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Achievement',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/activity.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Activity History',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/workout.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Workout Progress',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppText(
                  '    Notification',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/Notification.png",
                      scale: 3.5,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    AppText(
                      'Pop-up Notification',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Switch(
                      focusColor: Colors.deepPurpleAccent,
                      inactiveThumbColor: Colors.black,
                      value: button,
                      onChanged: (value) {
                        setState(() {
                          button = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 38.h,
                ),
                AppText(
                  '    Other',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/message.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Contact Us',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/privacy.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Privacy Policy',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      "assets/Icon-Setting.png",
                      scale: 4,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppText(
                      'Settings',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/arrow.png",
                      scale: 3,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
