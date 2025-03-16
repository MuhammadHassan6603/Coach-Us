import 'package:didpool/Utils/helper.dart';
import 'package:didpool/components/app_color.dart';
import 'package:didpool/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key,
    this.buttoncolor = AppColor.bluecolor,
    required this.title,
    required this.ontap,
    this.text = AppColor.whitecolor,
  });

  final buttoncolor;
  final String title;
  final VoidCallback ontap;
  final text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        height: 55,
        width: getWidth(context)*0.9,
        decoration: BoxDecoration(
          color: AppColor.bluecolor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: AppText(
            title,
            fontSize: 15.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
