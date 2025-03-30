import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class StatsSummaryCard extends StatelessWidget {
  final Map<String, dynamic> stats;
  
  const StatsSummaryCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff282335),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.directions_walk,
                  value: '${(stats['totalSteps'] / 1000).toStringAsFixed(1)}K',
                  label: 'Total Steps',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.water_drop,
                  value: stats['avgWaterIntake'].toString(),
                  label: 'Avg. Water',
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.fitness_center,
                  value: stats['workoutsCompleted'].toString(),
                  label: 'Workouts',
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department,
                  value: '${stats['streakDays']} days',
                  label: 'Current Streak',
                  isHighlighted: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    bool isHighlighted = false,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: isHighlighted
                ? const Color(0xff4023D7).withOpacity(0.2)
                : const Color(0xff1F1926).withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isHighlighted
                ? const Color(0xff4023D7)
                : const Color(0xffE9E3E4),
            size: 22.sp,
          ),
        ),
        SizedBox(height: 8.h),
        AppText(
          value,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xffE9E3E4),
        ),
        SizedBox(height: 4.h),
        AppText(
          label,
          fontSize: 12.sp,
          color: const Color(0xffE9E3E4).withOpacity(0.7),
        ),
      ],
    );
  }
}