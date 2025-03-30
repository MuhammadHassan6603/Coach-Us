import 'package:didpool/workout/workout_progress/workout_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/models/workout_model/workout_model.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutDetailsScreen({
    super.key, 
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          'Workout Details',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffE9E3E4)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                
                // Workout name and category
                AppText(
                  workout.name,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 5.h),
                
                // Category and difficulty tags
                Row(
                  children: [
                    _buildTag(workout.category, const Color(0xff4023D7)),
                    SizedBox(width: 10.w),
                    _buildTag(workout.difficulty, const Color(0xff6B4EFF)),
                  ],
                ),
                
                SizedBox(height: 20.h),
                
                // Workout stats
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: const Color(0xff2A2333),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat('Duration', workout.duration),
                      _buildDivider(),
                      _buildStat('Exercises', workout.exercises.toString()),
                      _buildDivider(),
                      _buildStat('Equipment', workout.equipment),
                    ],
                  ),
                ),
                
                SizedBox(height: 25.h),
                
                // Description
                AppText(
                  'Description',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 10.h),
                AppText(
                  workout.description,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffE0E0E0),
                ),
                
                SizedBox(height: 25.h),
                
                // Workout steps preview
                AppText(
                  'Workout Plan',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 15.h),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workout.steps.length,
                  itemBuilder: (context, index) {
                    final step = workout.steps[index];
                    return _buildWorkoutStep(step, index);
                  },
                ),
                
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: const BoxDecoration(
          color: Color(0xff2A2333),
          border: Border(
            top: BorderSide(color: Color(0xff3D3546), width: 1),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => WorkoutInProgressScreen(workout: workout),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4023D7),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Text(
            'Start Workout',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText(
        text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
  
  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        AppText(
          value,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xffE9E3E4),
        ),
        SizedBox(height: 5.h),
        AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ],
    );
  }
  
  Widget _buildDivider() {
    return Container(
      height: 40.h,
      width: 1,
      color: const Color(0xff3D3546),
    );
  }
  
  Widget _buildWorkoutStep(WorkoutStep step, int index) {
    final minutes = (step.durationSeconds / 60).floor();
    final seconds = step.durationSeconds % 60;
    final durationText = '${minutes}m ${seconds}s';
    
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: const Color(0xff2A2333),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: const Color(0xff4023D7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: AppText(
                '${index + 1}',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
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
                  step.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 5.h),
                AppText(
                  step.description,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color:Color(0xffE0E0E0),
                ),
                SizedBox(height: 5.h),
                AppText(
                  durationText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6B4EFF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}