import 'package:didpool/services/workout_service.dart';
import 'package:didpool/workout/workout_details/workout_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/models/workout_model/workout_model.dart';
import 'widgets/level_selector.dart';
import 'widgets/workout_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WorkoutService _firebaseService = WorkoutService();
  String selectedLevel = "Beginner";
  
  WorkoutModel? featuredWorkout;
  
  @override
  void initState() {
    super.initState();
    _initializeAppData();
    _loadFeaturedWorkout();
  }

  Future<void> _initializeAppData() async {
    await _firebaseService.initializeSampleWorkouts();
    if (_firebaseService.currentUserId != null) {
      await _firebaseService.createInitialUserStats();
    }
  }
  
  Future<void> _loadFeaturedWorkout() async {
    final beginnerWorkouts = await _firebaseService.getWorkoutsByDifficulty("Beginner").first;
    if (beginnerWorkouts.isNotEmpty) {
      setState(() {
        featuredWorkout = beginnerWorkouts.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          'Workout Center',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildWorkoutRoutinesContent(),
    );
  }
  
  Widget _buildWorkoutRoutinesContent() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              AppText(
                'Choose Level',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xffE9E3E4),
              ),
              SizedBox(height: 15.h),
              LevelSelector(
                selectedLevel: selectedLevel,
                onLevelSelected: (level) {
                  setState(() {
                    selectedLevel = level;
                  });
                },
              ),
              SizedBox(height: 25.h),
              StreamBuilder<List<WorkoutModel>>(
                stream: _firebaseService.getWorkoutsByDifficulty(selectedLevel),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading workouts: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  
                  final workouts = snapshot.data ?? [];
                  
                  if (workouts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: AppText(
                          'No workouts found for $selectedLevel level',
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  
                  return Column(
                    children: workouts.map((workout) => 
                      WorkoutCard(
                        workout: workout,
                        onTap: () => _navigateToWorkoutDetails(workout),
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
  
  void _navigateToWorkoutDetails(WorkoutModel workout) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => WorkoutDetailsScreen(workout: workout),
      ),
    );
  }
}