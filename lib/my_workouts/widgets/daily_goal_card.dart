import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class DailyGoalCard extends StatelessWidget {
  final Map<String, dynamic> goalData;

  const DailyGoalCard({
    Key? key,
    required this.goalData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff2D2535),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Goal icon
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: goalData['isCompleted']
                  ? const Color(0xff4023D7).withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              goalData['icon'] as IconData,
              color: goalData['isCompleted']
                  ? const Color(0xff4023D7)
                  : Colors.grey,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 15.w),
          
          // Goal text
          Expanded(
            child: AppText(
              goalData['title'] as String,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: goalData['isCompleted']
                  ? const Color(0xffE9E3E4)
                  : Colors.grey,
            ),
          ),
          
          // Completion checkbox
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: goalData['isCompleted']
                  ? const Color(0xff4023D7)
                  : Colors.transparent,
              border: Border.all(
                color: goalData['isCompleted']
                    ? const Color(0xff4023D7)
                    : Colors.grey,
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: goalData['isCompleted']
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.sp,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}