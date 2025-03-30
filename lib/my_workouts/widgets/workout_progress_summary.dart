import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkoutProgressSummary extends StatelessWidget {
  final int weeklyWorkouts;
  final int totalWeeklyGoal;
  final int monthlyWorkoutMinutes;
  final Map<String, double>? dailyActivityPercentages;
  final Function(int) onGoalUpdated;

  const WorkoutProgressSummary({
    Key? key,
    required this.weeklyWorkouts,
    required this.totalWeeklyGoal,
    required this.monthlyWorkoutMinutes,
    this.dailyActivityPercentages,
    required this.onGoalUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the days of the week in correct order: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    // Default monthly goal (in minutes)
    const int monthlyGoalMinutes = 600;
    
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff2D2535),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                'This Week',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xffE9E3E4),
              ),
              // Add edit goal button
              InkWell(
                onTap: () => _showEditGoalDialog(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff4023D7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: const Color(0xffE9E3E4),
                        size: 16.sp,
                      ),
                      SizedBox(width: 5.w),
                      AppText(
                        'Edit Goal',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffE9E3E4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              // Weekly workouts circular progress
              Expanded(
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 40.r,
                      lineWidth: 8.w,
                      animation: true,
                      percent: totalWeeklyGoal > 0 
                          ? (weeklyWorkouts / totalWeeklyGoal).clamp(0.0, 1.0) 
                          : 0.0,
                      center: AppText(
                        '$weeklyWorkouts/$totalWeeklyGoal',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffE9E3E4),
                      ),
                      progressColor: const Color(0xff4023D7),
                      backgroundColor: const Color(0xff4023D7).withOpacity(0.2),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    SizedBox(height: 10.h),
                    AppText(
                      'Workouts',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              // Monthly minutes progress
              Expanded(
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 40.r,
                      lineWidth: 8.w,
                      animation: true,
                      percent: (monthlyWorkoutMinutes / monthlyGoalMinutes).clamp(0.0, 1.0),
                      center: AppText(
                        '$monthlyWorkoutMinutes',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffE9E3E4),
                      ),
                      footer: AppText(
                        'of $monthlyGoalMinutes min',
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                      progressColor: const Color(0xff4023D7),
                      backgroundColor: const Color(0xff4023D7).withOpacity(0.2),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    SizedBox(height: 10.h),
                    AppText(
                      'Minutes',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AppText(
            'Daily Activity',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffE9E3E4),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayNames.map((day) {
              // Get activity percentage for this day from the map or default to 0.0
              final activityPercent = dailyActivityPercentages != null 
                  ? dailyActivityPercentages![day] ?? 0.0 
                  : 0.0;
              
              return _buildDayActivity(day, activityPercent);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayActivity(String day, double percent) {
    // Get current day name to highlight today
    final now = DateTime.now();
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final todayName = dayNames[now.weekday - 1]; // weekday is 1-7 for Mon-Sun
    final isToday = day == todayName;
    
    return Column(
      children: [
        Container(
          width: 30.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: const Color(0xff1F1926),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30.w,
                height: 80.h * percent,
                decoration: BoxDecoration(
                  color: percent > 0 
                      ? const Color(0xff4023D7) 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        AppText(
          day,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: isToday ? const Color(0xff4023D7) : Colors.grey,
        ),
      ],
    );
  }
  
  void _showEditGoalDialog(BuildContext context) {
    int newGoal = totalWeeklyGoal;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff2D2535),
        title: AppText(
          'Edit Weekly Goal',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xffE9E3E4),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Set your weekly workout goal:',
              fontSize: 14.sp,
              color: Colors.grey,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: const Color(0xff4023D7),
                    size: 30.sp,
                  ),
                  onPressed: () {
                    if (newGoal > 1) {
                      newGoal--;
                      (context as Element).markNeedsBuild();
                    }
                  },
                ),
                SizedBox(width: 15.w),
                AppText(
                  '$newGoal',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(width: 15.w),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: const Color(0xff4023D7),
                    size: 30.sp,
                  ),
                  onPressed: () {
                    newGoal++;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: AppText(
              'Cancel',
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4023D7),
            ),
            onPressed: () {
              onGoalUpdated(newGoal);
              Navigator.pop(context);
            },
            child: AppText(
              'Save',
              fontSize: 14.sp,
              color: const Color(0xffE9E3E4),
            ),
          ),
        ],
      ),
    );
  }
}