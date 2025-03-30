import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class ProfileInfoWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileInfoWidget({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xff282335),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45.r,
            backgroundColor: const Color(0xff4023D7),
            child: CircleAvatar(
              radius: 42.r,
              backgroundImage: (userData['profilePic'] != null &&
                      userData['profilePic'].isNotEmpty)
                  ? FileImage(File(userData['profilePic']))
                  : null,
              child: (userData['profilePic'] == null ||
                      userData['profilePic'].isEmpty)
                  ? Icon(Icons.person,
                      size: 42.r, color: const Color(0xffE9E3E4))
                  : null,
            ),
          ),
          SizedBox(height: 15.h),
          AppText(
            userData['name'],
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
          SizedBox(height: 5.h),
          AppText(
            userData['email'],
            fontSize: 14.sp,
            color: const Color(0xffE9E3E4).withOpacity(0.7),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xff4023D7).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.sp,
                  color: const Color(0xff4023D7),
                ),
                SizedBox(width: 8.w),
                AppText(
                  'Member since ${userData['memberSince']}',
                  fontSize: 12.sp,
                  color: const Color(0xffE9E3E4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
