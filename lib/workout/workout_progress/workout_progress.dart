import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didpool/bottom_bar/bottom_bar.dart';
import 'package:didpool/models/logged_workout_model/logged_workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/models/workout_model/workout_model.dart';
import 'package:didpool/services/workout_service.dart';

class WorkoutInProgressScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutInProgressScreen({
    super.key,
    required this.workout,
  });

  @override
  State<WorkoutInProgressScreen> createState() => _WorkoutInProgressScreenState();
}

class _WorkoutInProgressScreenState extends State<WorkoutInProgressScreen> {
  int currentStepIndex = 0;
  bool isWorkoutComplete = false;
  Timer? timer;
  int timeRemaining = 0;
  int elapsedTimeInSeconds = 0;
  DateTime workoutStartTime = DateTime.now();
  final WorkoutService _workoutService = WorkoutService();
  
  @override
  void initState() {
    super.initState();
    startStepTimer();
  }
  
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  
  void startStepTimer() {
    // Reset timer and set the duration for the current step
    timer?.cancel();
    
    if (currentStepIndex < widget.workout.steps.length) {
      setState(() {
        timeRemaining = widget.workout.steps[currentStepIndex].durationSeconds;
      });
      
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (timeRemaining > 0) {
            timeRemaining--;
            elapsedTimeInSeconds++;
          } else {
            // Auto-advance to next step if timer reaches zero
            if (currentStepIndex < widget.workout.steps.length - 1) {
              moveToNextStep();
            } else {
              completeWorkout();
            }
          }
        });
      });
    }
  }
  
  void moveToNextStep() {
    if (currentStepIndex < widget.workout.steps.length - 1) {
      setState(() {
        currentStepIndex++;
      });
      startStepTimer();
    } else {
      completeWorkout();
    }
  }
  
  void moveToPreviousStep() {
    if (currentStepIndex > 0) {
      setState(() {
        currentStepIndex--;
      });
      startStepTimer();
    }
  }
  
  void completeWorkout() {
    timer?.cancel();
    setState(() {
      isWorkoutComplete = true;
    });
  }
  
  Future<void> finishWorkout() async {
  // Calculate total workout duration
  final workoutDuration = elapsedTimeInSeconds;
  final durationMinutes = (workoutDuration / 60).ceil();
  
  // Format duration as string (e.g., "15:30")
  final minutes = (workoutDuration ~/ 60).toString();
  final seconds = (workoutDuration % 60).toString().padLeft(2, '0');
  final durationString = "$minutes:$seconds";
  
  // Calculate estimated calories (you might have a better formula)
  // Simple placeholder calculation
  final estimatedCalories = durationMinutes * 5;
  final loggedWorkout = LoggedWorkoutModel(
    id: '',
    workoutId: widget.workout.id,
    workoutName: widget.workout.name,
    dateTime: DateTime.now(),
    duration: durationString,
    durationMinutes: durationMinutes,
    calories: estimatedCalories,
    userId: _workoutService.currentUserId ?? 'unknown',
  );
  
  try {
    await _workoutService.logWorkout(loggedWorkout);

     
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workout completed and logged!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomBarScreen()));
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging workout: $e')),
      );
    }
  }
}
  
  @override
  Widget build(BuildContext context) {
    if (isWorkoutComplete) {
      return _buildWorkoutCompleteScreen();
    }
    
    final currentStep = widget.workout.steps[currentStepIndex];
    final totalSteps = widget.workout.steps.length;
    
    // Format time remaining
    final minutes = (timeRemaining / 60).floor();
    final seconds = timeRemaining % 60;
    final timeText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          widget.workout.name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xffE9E3E4)),
          onPressed: () => _showExitConfirmationDialog(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              
              // Progress indicator
              Row(
                children: [
                  AppText(
                    'Step ${currentStepIndex + 1} of $totalSteps',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffE9E3E4),
                  ),
                  const Spacer(),
                  AppText(
                    'Total: ${_formatElapsedTime()}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: (currentStepIndex + 1) / totalSteps,
                  backgroundColor: const Color(0xff2A2333),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff4023D7)),
                  minHeight: 10.h,
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // Current step details
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2333),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      currentStep.title,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffE9E3E4),
                      // textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    AppText(
                      currentStep.description,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color:Color(0xffE0E0E0),
                      // textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    
                    // Timer display
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                      decoration: BoxDecoration(
                        color: const Color(0xff1F1926),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          AppText(
                            'Time Remaining',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10.h),
                          AppText(
                            timeText,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffE9E3E4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Previous button (disabled if on first step)
                  IconButton(
                    onPressed: currentStepIndex > 0 ? moveToPreviousStep : null,
                    icon: const Icon(Icons.arrow_back_ios),
                    color: currentStepIndex > 0 ? const Color(0xffE9E3E4) : Colors.grey,
                    iconSize: 28.r,
                  ),
                  
                  // Skip/Next button
                  ElevatedButton(
                    onPressed: moveToNextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4023D7),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      currentStepIndex < widget.workout.steps.length - 1 ? 'Next' : 'Complete',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Placeholder to maintain spacing
                  SizedBox(width: 28.r),
                ],
              ),
              
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWorkoutCompleteScreen() {
    final totalDurationMinutes = (elapsedTimeInSeconds / 60).ceil();
    
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          'Workout Complete',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              
              // Success icon
              Container(
                width: 100.w,
                height: 100.w,
                decoration: const BoxDecoration(
                  color: Color(0xff4023D7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 60.r,
                  color: Colors.white,
                ),
              ),
              
              SizedBox(height: 30.h),
              
              AppText(
                'Great job!',
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xffE9E3E4),
              ),
              
              SizedBox(height: 10.h),
              
              AppText(
                'You have completed the workout',
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color:Color(0xffE0E0E0),
              ),
              
              SizedBox(height: 40.h),
              
              // Workout summary
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2333),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  children: [
                    _buildSummaryItem('Workout', widget.workout.name),
                    SizedBox(height: 15.h),
                    _buildSummaryItem('Duration', '$totalDurationMinutes minutes'),
                    SizedBox(height: 15.h),
                    _buildSummaryItem('Exercises', '${widget.workout.steps.length} completed'),
                    SizedBox(height: 15.h),
                    _buildSummaryItem('Difficulty', widget.workout.difficulty),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Finish button
              ElevatedButton(
                onPressed: finishWorkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4023D7),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 55.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  'Finish Workout',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSummaryItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
        AppText(
          value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xffE9E3E4),
        ),
      ],
    );
  }
  
  String _formatElapsedTime() {
    final minutes = (elapsedTimeInSeconds / 60).floor();
    final seconds = elapsedTimeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  
  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff2A2333),
        title: Text(
          'Exit Workout?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        content: Text(
          'Are you sure you want to exit? Your progress will be lost.',
          style: GoogleFonts.poppins(
            color: Colors.grey[300],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close workout screen
            },
            child: Text(
              'Exit',
              style: GoogleFonts.poppins(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}