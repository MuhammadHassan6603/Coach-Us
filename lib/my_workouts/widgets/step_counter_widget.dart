import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StepCounterWidget extends StatelessWidget {
  final int currentSteps;
  final int stepGoal;

  const StepCounterWidget({
    Key? key,
    required this.currentSteps,
    required this.stepGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progressPercent = currentSteps / stepGoal;
    final int caloriesBurned = (currentSteps * 0.04).round(); 
    final double distanceKm = currentSteps * 0.0008; 
    
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff2D2535),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_walk,
                color: const Color(0xff4023D7),
                size: 24.sp,
              ),
              SizedBox(width: 10.w),
              AppText(
                'Step Counter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xffE9E3E4),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xff4023D7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppText(
                  'Today',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff4023D7),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              CircularPercentIndicator(
                radius: 60.r,
                lineWidth: 12.w,
                animation: true,
                percent: progressPercent > 1.0 ? 1.0 : progressPercent,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      currentSteps.toString(),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffE9E3E4),
                    ),
                    AppText(
                      'steps',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ],
                ),
                progressColor: const Color(0xff4023D7),
                backgroundColor: const Color(0xff4023D7).withOpacity(0.2),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  _buildMetricRow(
                    Icons.flag_outlined,
                    'Goal',
                    '$stepGoal steps',
                    const Color(0xff4023D7),
                  ),
                  SizedBox(height: 15.h),
                  
                  
                  _buildMetricRow(
                    Icons.local_fire_department_outlined,
                    'Calories',
                    '$caloriesBurned kcal',
                    Colors.orange,
                  ),
                  SizedBox(height: 15.h),
                  
                  
                  _buildMetricRow(
                    Icons.straighten_outlined,
                    'Distance',
                    '${distanceKm.toStringAsFixed(2)} km',
                    Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 16.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              label,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            AppText(
              value,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xffE9E3E4),
            ),
          ],
        ),
      ],
    );
  }
}