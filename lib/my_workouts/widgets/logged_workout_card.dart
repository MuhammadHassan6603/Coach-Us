import 'package:didpool/models/logged_workout_model/logged_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class LoggedWorkoutCard extends StatelessWidget {
  final LoggedWorkoutModel loggedWorkout;
  final VoidCallback? onTap;

  const LoggedWorkoutCard({
    Key? key,
    required this.loggedWorkout,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: const Color(0xff373142),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: const BoxDecoration(
                color: Color(0xff4023D7),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    loggedWorkout.workoutName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffE9E3E4),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      AppText(
                        '${loggedWorkout.formattedDate} • ${loggedWorkout.formattedTime}',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                  loggedWorkout.duration,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 5.h),
                AppText(
                  '${loggedWorkout.calories} cal',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}