import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;
  
  const AchievementCard({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff282335),
        borderRadius: BorderRadius.circular(12.r),
        border: achievement['earned']
            ? Border.all(color: const Color(0xff4023D7), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: achievement['earned']
                  ? const Color(0xff4023D7).withOpacity(0.2)
                  : const Color(0xff1F1926).withOpacity(0.4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              achievement['icon'],
              color: achievement['earned']
                  ? const Color(0xff4023D7)
                  : const Color(0xffE9E3E4).withOpacity(0.5),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 15.w),
          
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        achievement['title'],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffE9E3E4),
                      ),
                    ),
                    if (achievement['earned'])
                      Icon(
                        Icons.verified,
                        color: const Color(0xff4023D7),
                        size: 18.sp,
                      ),
                  ],
                ),
                SizedBox(height: 5.h),
                AppText(
                  achievement['description'],
                  fontSize: 12.sp,
                  color: const Color(0xffE9E3E4).withOpacity(0.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}