import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/models/workout_model/workout_model.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final VoidCallback? onTap;

  const WorkoutCard({
    Key? key,
    required this.workout,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        height: 120.h,
        decoration: BoxDecoration(
          color: const Color(0xff373142),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Container(
              height: 120.h,
              width: 110.w,
              decoration: BoxDecoration(
                color: const Color(0xff4023D7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                ),
              ),
              child: Center(
                child: Icon(
                  _getWorkoutIcon(),
                  color: Colors.white,
                  size: 40.sp,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      workout.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffE9E3E4),
                    ),
                    AppText(
                      workout.description,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        _buildInfoItem(Icons.timer, workout.duration),
                        SizedBox(width: 10.w),
                        _buildInfoItem(Icons.fitness_center, '${workout.exercises} exercises'),
                        // SizedBox(width: 10.w),
                        // _buildInfoItem(Icons.sports_gymnastics, workout.equipment),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 14.sp,
        ),
        SizedBox(width: 5.w),
        AppText(
          text,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ],
    );
  }

  IconData _getWorkoutIcon() {
    // Return appropriate icon based on workout category or type
    switch (workout.category.toLowerCase()) {
      case 'cardio':
        return Icons.directions_run;
      case 'strength':
        return Icons.fitness_center;
      case 'hiit':
        return Icons.bolt;
      case 'flexibility':
        return Icons.self_improvement;
      case 'crossfit':
        return Icons.timer;
      case 'full body':
        return Icons.accessibility_new;
      default:
        return Icons.sports_gymnastics;
    }
  }
}