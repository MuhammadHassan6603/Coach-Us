import 'package:didpool/models/logged_workout_model/logged_workout_model.dart';
import 'package:didpool/models/user_stats_model/user_stats_model.dart';
import 'package:didpool/my_workouts/widgets/logged_workout_card.dart';
import 'package:didpool/my_workouts/widgets/workout_progress_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/services/workout_service.dart';
import 'package:didpool/workout/workout_details/workout_details.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  final WorkoutService _firebaseService = WorkoutService();

  WorkoutHistoryScreen({super.key});

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
          'Workout History',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
      ),
      body: _buildFullWorkoutHistory(),
    );
  }

  Widget _buildFullWorkoutHistory() {
    return StreamBuilder<List<LoggedWorkoutModel>>(
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
        
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ...workouts.map((workout) => 
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: LoggedWorkoutCard(
                      loggedWorkout: workout,
                      onTap: () {
                        _navigateToLoggedWorkoutDetails(context, workout);
                      },
                    ),
                  )
                ).toList(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToLoggedWorkoutDetails(BuildContext context, LoggedWorkoutModel loggedWorkout) {
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
              
              // Stream builder for user stats
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
                    monthlyWorkoutMinutes: userStats?.monthlyWorkoutMinutes ?? 0,
                    dailyActivityPercentages: userStats?.dailyActivityPercentages,
                    onGoalUpdated: (newGoal) {
                      _firebaseService.updateWeeklyGoal(newGoal);
                    },
                  );
                },
              ),
              SizedBox(height: 25.h),
              
              // Workout history section
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
                          // Navigate to full history screen
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
              
              // Stream builder for logged workouts
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
                  
                  // Show only last 4 workouts
                  final displayWorkouts = workouts.take(4).toList();
                  
                  return Column(
                    children: displayWorkouts.map((workout) => 
                      LoggedWorkoutCard(
                        loggedWorkout: workout,
                        onTap: () {
                          _navigateToLoggedWorkoutDetails(workout);
                        },
                      )
                    ).toList(),
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
    // First fetch the original workout using the workoutId
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