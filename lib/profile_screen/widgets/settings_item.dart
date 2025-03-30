import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class SettingsItem extends StatelessWidget {
  final Map<String, dynamic> settingData;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.settingData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: const Color(0xff282335),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: const Color(0xff1F1926).withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                settingData['icon'],
                color: const Color(0xffE9E3E4),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 15.w),
            
            Expanded(
              child: AppText(
                settingData['title'],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffE9E3E4),
              ),
            ),
            
            if (settingData['hasNotification'])
              Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                  color: Color(0xff4023D7),
                  shape: BoxShape.circle,
                ),
              ),
            SizedBox(width: 10.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xffE9E3E4).withOpacity(0.7),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}