import 'package:didpool/models/logged_workout_model/logged_workout_model.dart';
import 'package:didpool/models/user_stats_model/user_stats_model.dart';
import 'package:didpool/my_workouts/widgets/logged_workout_card.dart';
import 'package:didpool/my_workouts/widgets/workout_progress_summary.dart';
import 'package:didpool/my_workouts/workout_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/services/workout_service.dart';
import 'package:didpool/workout/workout_details/workout_details.dart';

class MyWorkoutsScreen extends StatefulWidget {
  const MyWorkoutsScreen({super.key});

  @override
  State<MyWorkoutsScreen> createState() => _MyWorkoutsScreenState();
}

class _MyWorkoutsScreenState extends State<MyWorkoutsScreen> {
  final WorkoutService _firebaseService = WorkoutService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        primary: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          'My Workouts',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
      ),
      body: _buildWorkoutTrackingContent(),
    );
  }

  Widget _buildWorkoutTrackingContent() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              StreamBuilder<UserStatsModel?>(
                stream: _firebaseService.getUserStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final userStats = snapshot.data;

                  return WorkoutProgressSummary(
                    weeklyWorkouts: userStats?.weeklyWorkouts ?? 0,
                    totalWeeklyGoal: userStats?.totalWeeklyGoal ?? 5,
                    monthlyWorkoutMinutes:
                        userStats?.monthlyWorkoutMinutes ?? 0,
                    dailyActivityPercentages:
                        userStats?.dailyActivityPercentages,
                    onGoalUpdated: (newGoal) {
                      _firebaseService.updateWeeklyGoal(newGoal);
                    },
                  );
                },
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  AppText(
                    'Workout History',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffE9E3E4),
                  ),
                  const Spacer(),
                  Container(
                    height: 30.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff4023D7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutHistoryScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                          child: AppText(
                            'See All',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffE9E3E4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              StreamBuilder<List<LoggedWorkoutModel>>(
                stream: _firebaseService.getUserLoggedWorkouts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading workout history: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final workouts = snapshot.data ?? [];

                  final displayWorkouts = workouts.take(3).toList();

                  if (workouts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Column(
                          children: [
                            AppText(
                              'No workout history yet',
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10.h),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff4023D7),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Find a workout'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: displayWorkouts
                        .map((workout) => LoggedWorkoutCard(
                              loggedWorkout: workout,
                              onTap: () {
                                _navigateToLoggedWorkoutDetails(workout);
                              },
                            ))
                        .toList(),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLoggedWorkoutDetails(LoggedWorkoutModel loggedWorkout) {
    _firebaseService.getWorkoutById(loggedWorkout.workoutId).then((workout) {
      if (workout != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDetailsScreen(workout: workout),
          ),
        );
      }
    });
  }
}
