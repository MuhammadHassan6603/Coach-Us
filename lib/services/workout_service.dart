import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didpool/models/logged_workout_model/logged_workout_model.dart';
import 'package:didpool/models/user_stats_model/user_stats_model.dart';
import 'package:didpool/models/workout_model/workout_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String? get currentUserId => _auth.currentUser?.uid;

  Stream<List<WorkoutModel>> getWorkoutsByDifficulty(String difficulty) {
    return _firestore
        .collection('workouts')
        .where('difficulty', isEqualTo: difficulty)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => WorkoutModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<WorkoutModel?> getWorkoutById(String workoutId) async {
    final doc = await _firestore.collection('workouts').doc(workoutId).get();
    if (doc.exists) {
      return WorkoutModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> resetUserStats(String userId) async {
  try {
    final now = DateTime.now();
    
    if (now.weekday == 1) {
      await FirebaseFirestore.instance
          .collection('user_stats')
          .doc(userId)
          .update({
        'weeklyWorkouts': 0,
      });
    }
    
    if (now.day == 1) {
      await FirebaseFirestore.instance
          .collection('user_stats')
          .doc(userId)
          .update({
        'monthlyWorkoutMinutes': 0,
      });
    }
  } catch (e) {
    print('Error resetting user stats: $e');
  }
}

  Future<String> logWorkout(LoggedWorkoutModel workout) async {
    final docRef = await _firestore.collection('logged_workouts').add(workout.toMap());
    
    await updateUserStatsAfterWorkout(workout.durationMinutes);
    
    return docRef.id;
  }

  Stream<List<LoggedWorkoutModel>> getUserLoggedWorkouts() {
    if (currentUserId == null) return Stream.value([]);
    
    return _firestore
        .collection('logged_workouts')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => LoggedWorkoutModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<UserStatsModel?> getUserStats() {
    if (currentUserId == null) return Stream.value(null);
    
    return _firestore
        .collection('user_stats')
        .where('userId', isEqualTo: currentUserId)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;
      return UserStatsModel.fromMap(snapshot.docs.first.data(), snapshot.docs.first.id);
    });
  }

  Future<void> createInitialUserStats() async {
    if (currentUserId == null) return;
    
    final existingStats = await _firestore
        .collection('user_stats')
        .where('userId', isEqualTo: currentUserId)
        .limit(1)
        .get();
    
    if (existingStats.docs.isNotEmpty) return;
    
    final Map<String, double> initialDailyActivity = {
      'Mon': 0.0,
      'Tue': 0.0,
      'Wed': 0.0,
      'Thu': 0.0,
      'Fri': 0.0,
      'Sat': 0.0,
      'Sun': 0.0,
    };
    
    final stats = UserStatsModel(
      id: '',
      userId: currentUserId!,
      weeklyWorkouts: 0,
      totalWeeklyGoal: 5, 
      monthlyWorkoutMinutes: 0,
      dailyActivityPercentages: initialDailyActivity,
    );
    
    await _firestore.collection('user_stats').doc(currentUserId).set(stats.toMap());
  }

  // Update user stats after completing a workout
  Future<void> updateUserStatsAfterWorkout(int durationMinutes) async {
  if (currentUserId == null) {
    print('Error: No user ID found');
    return;
  }
  
  try {
    // Reference the user stats document directly
    final statsDoc = _firestore.collection('user_stats').doc(currentUserId);
    
    // Get current stats
    final statsSnapshot = await statsDoc.get();
    
    if (!statsSnapshot.exists) {
      await createInitialUserStats();
      await updateUserStatsAfterWorkout(durationMinutes);
      return;
    }
    
    final currentStats = UserStatsModel.fromMap(statsSnapshot.data()!, statsSnapshot.id);
    
    // Get today's day name (Mon, Tue, etc.)
    final now = DateTime.now();
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final todayName = dayNames[now.weekday - 1];
    
    // Update daily activity for today
    final updatedDailyActivity = Map<String, double>.from(currentStats.dailyActivityPercentages);
    updatedDailyActivity[todayName] = 1.0;
    
    // Weekly reset logic - more robust implementation
    DateTime currentWeekStart = DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
    currentWeekStart = DateTime(currentWeekStart.year, currentWeekStart.month, currentWeekStart.day); // Normalize to start of day
    
    // Get timestamp of last workout
    final lastWorkoutQuery = await _firestore
        .collection('logged_workouts')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get();
    
    int newWeeklyWorkouts = currentStats.weeklyWorkouts + 1; // Default: increment
    int newMonthlyMinutes = currentStats.monthlyWorkoutMinutes + durationMinutes; // Default: increment
    
    // Only reset counters if we have previous workouts to compare with
    if (lastWorkoutQuery.docs.isNotEmpty) {
      final lastWorkoutDate = (lastWorkoutQuery.docs.first.data()['dateTime'] as Timestamp).toDate();
      
      // Calculate start of the week for last workout
      DateTime lastWorkoutWeekStart = DateTime(lastWorkoutDate.year, lastWorkoutDate.month, lastWorkoutDate.day)
          .subtract(Duration(days: lastWorkoutDate.weekday - 1));
      lastWorkoutWeekStart = DateTime(lastWorkoutWeekStart.year, lastWorkoutWeekStart.month, lastWorkoutWeekStart.day);
      
      // Reset weekly counter if we're in a new week
      bool isNewWeek = currentWeekStart.isAfter(lastWorkoutWeekStart);
      if (isNewWeek) {
        newWeeklyWorkouts = 1; // Reset to 1 for the first workout of a new week
      }
      
      // Check if this is a new month
      final currentMonth = DateTime(now.year, now.month);
      final lastWorkoutMonth = DateTime(lastWorkoutDate.year, lastWorkoutDate.month);
      
      bool isNewMonth = currentMonth.isAfter(lastWorkoutMonth);
      if (isNewMonth) {
        newMonthlyMinutes = durationMinutes; // Reset monthly minutes for a new month
      }
    }
    
    // Use a transaction for consistent updates
    await _firestore.runTransaction((transaction) async {
      // Get the latest document snapshot in the transaction
      final latestSnapshot = await transaction.get(statsDoc);
      
      // Ensure document exists and hasn't been deleted
      if (!latestSnapshot.exists) {
        throw Exception('User stats document no longer exists');
      }
      
      // Update the document
      transaction.update(statsDoc, {
        'weeklyWorkouts': newWeeklyWorkouts,
        'monthlyWorkoutMinutes': newMonthlyMinutes,
        'dailyActivityPercentages': updatedDailyActivity,
      });
    });
    
  } catch (e) {
    print('Error updating user stats: $e');
    // Consider adding analytics logging for production
  }
}

  // Update weekly workout goal
  Future<void> updateWeeklyGoal(int newGoal) async {
    if (currentUserId == null) return;
    
    final statsQuery = await _firestore
        .collection('user_stats')
        .where('userId', isEqualTo: currentUserId)
        .limit(1)
        .get();
    
    if (statsQuery.docs.isEmpty) {
      await createInitialUserStats();
      await updateWeeklyGoal(newGoal);
      return;
    }
    
    await _firestore.collection('user_stats').doc(statsQuery.docs.first.id).update({
      'totalWeeklyGoal': newGoal,
    });
  }

  // WORKOUT DATA INITIALIZATION
  
  // Initialize sample workouts (only call this once when setting up the app)
  Future<void> initializeSampleWorkouts() async {
    // Check if workouts already exist
    final existingWorkouts = await _firestore.collection('workouts').limit(1).get();
    if (existingWorkouts.docs.isNotEmpty) return;
    
    final workouts = _getSampleWorkouts();
    
    // Add workouts in batches
    final batch = _firestore.batch();
    
    for (var workout in workouts) {
      final docRef = _firestore.collection('workouts').doc();
      batch.set(docRef, workout.toMap());
    }
    
    await batch.commit();
  }
  
  // Sample workout data
  List<WorkoutModel> _getSampleWorkouts() {
    return [
      WorkoutModel(
        id: '',
        name: 'Full Body Basics',
        description: 'Simple full-body workout for beginners',
        duration: '30 mins',
        exercises: 5,
        equipment: 'Minimal',
        difficulty: 'Beginner',
        category: 'Full Body',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Light jogging in place for 2 minutes',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Push-ups',
            description: '3 sets of 8 reps with 30 seconds rest between sets',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Bodyweight Squats',
            description: '3 sets of 10 reps with 30 seconds rest between sets',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Plank',
            description: '3 sets of 30 seconds hold with 30 seconds rest',
            durationSeconds: 180,
          ),
          WorkoutStep(
            title: 'Jumping Jacks',
            description: '3 sets of 30 seconds with 15 seconds rest',
            durationSeconds: 135,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Light stretching for all major muscle groups',
            durationSeconds: 180,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: 'Cardio Starter',
        description: 'Basic cardio routine to build endurance',
        duration: '20 mins',
        exercises: 4,
        equipment: 'None',
        difficulty: 'Beginner',
        category: 'Cardio',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Marching in place for 2 minutes',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Jumping Jacks',
            description: '3 sets of 45 seconds with 30 seconds rest',
            durationSeconds: 225,
          ),
          WorkoutStep(
            title: 'High Knees',
            description: '3 sets of 30 seconds with 30 seconds rest',
            durationSeconds: 180,
          ),
          WorkoutStep(
            title: 'Butt Kicks',
            description: '3 sets of 30 seconds with 30 seconds rest',
            durationSeconds: 180,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Walking in place slowly for 1 minute, then stretching',
            durationSeconds: 180,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: 'Flexibility Focus',
        description: 'Simple stretches to improve flexibility',
        duration: '25 mins',
        exercises: 6,
        equipment: 'Yoga mat',
        difficulty: 'Beginner',
        category: 'Flexibility',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Light walking in place for 2 minutes',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Neck & Shoulder Stretches',
            description: 'Gentle neck rolls and shoulder circles, 30 seconds each direction',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Standing Forward Bend',
            description: 'Hold for 60 seconds, remember to breathe deeply',
            durationSeconds: 60,
          ),
          WorkoutStep(
            title: 'Seated Hamstring Stretch',
            description: 'Hold for 60 seconds per leg',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Hip Flexor Stretch',
            description: 'Hold for 60 seconds per side',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Cat-Cow Pose',
            description: '10 slow repetitions, focusing on breathing',
            durationSeconds: 120,
          ),
          WorkoutStep(
            title: 'Final Relaxation',
            description: 'Lie on your back and relax for 2 minutes',
            durationSeconds: 120,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: 'Split Training',
        description: 'Upper/lower body split for intermediate users',
        duration: '45 mins',
        exercises: 8,
        equipment: 'Dumbbells',
        difficulty: 'Intermediate',
        category: 'Strength',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Dynamic stretching and light cardio for 5 minutes',
            durationSeconds: 300,
          ),
          WorkoutStep(
            title: 'Dumbbell Bench Press',
            description: '4 sets of 10 reps with 60 seconds rest',
            durationSeconds: 480,
          ),
          WorkoutStep(
            title: 'Bent-Over Rows',
            description: '4 sets of 10 reps with 60 seconds rest',
            durationSeconds: 480,
          ),
          WorkoutStep(
            title: 'Shoulder Press',
            description: '3 sets of 12 reps with 60 seconds rest',
            durationSeconds: 360,
          ),
          WorkoutStep(
            title: 'Bicep Curls',
            description: '3 sets of 12 reps with 45 seconds rest',
            durationSeconds: 270,
          ),
          WorkoutStep(
            title: 'Tricep Extensions',
            description: '3 sets of 12 reps with 45 seconds rest',
            durationSeconds: 270,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Static stretching focusing on worked muscle groups',
            durationSeconds: 300,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: 'HIIT Circuit',
        description: 'High intensity interval training circuit',
        duration: '30 mins',
        exercises: 6,
        equipment: 'Various',
        difficulty: 'Intermediate',
        category: 'HIIT',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Dynamic movements for 3 minutes',
            durationSeconds: 180,
          ),
          WorkoutStep(
            title: 'Circuit Round 1',
            description: '30 seconds each: Burpees, Mountain Climbers, Jump Squats, Push-ups. Rest 1 minute after completion.',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Circuit Round 2',
            description: '30 seconds each: Burpees, Mountain Climbers, Jump Squats, Push-ups. Rest 1 minute after completion.',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Circuit Round 3',
            description: '30 seconds each: Burpees, Mountain Climbers, Jump Squats, Push-ups. Rest 1 minute after completion.',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Circuit Round 4',
            description: '30 seconds each: Burpees, Mountain Climbers, Jump Squats, Push-ups. Rest 1 minute after completion.',
            durationSeconds: 240,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Slow walking followed by static stretches for 3 minutes',
            durationSeconds: 180,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: '5x5 Strength',
        description: 'Heavy compound movements for strength',
        duration: '60 mins',
        exercises: 5,
        equipment: 'Barbell, rack',
        difficulty: 'Advanced',
        category: 'Strength',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Mobility work and light cardio for 5 minutes',
            durationSeconds: 300,
          ),
          WorkoutStep(
            title: 'Squats',
            description: '5 sets of 5 reps with 2-3 minutes rest between sets',
            durationSeconds: 750,
          ),
          WorkoutStep(
            title: 'Bench Press',
            description: '5 sets of 5 reps with 2-3 minutes rest between sets',
            durationSeconds: 750,
          ),
          WorkoutStep(
            title: 'Barbell Rows',
            description: '5 sets of 5 reps with 2-3 minutes rest between sets',
            durationSeconds: 750,
          ),
          WorkoutStep(
            title: 'Overhead Press',
            description: '5 sets of 5 reps with 2-3 minutes rest between sets',
            durationSeconds: 750,
          ),
          WorkoutStep(
            title: 'Deadlift',
            description: '1 set of 5 reps',
            durationSeconds: 300,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Static stretching for all major muscle groups',
            durationSeconds: 300,
          ),
        ],
      ),
      WorkoutModel(
        id: '',
        name: 'CrossFit WOD',
        description: 'Intense cross-training workout',
        duration: '45 mins',
        exercises: 4,
        equipment: 'Various',
        difficulty: 'Advanced',
        category: 'CrossFit',
        steps: [
          WorkoutStep(
            title: 'Warm-up',
            description: 'Dynamic movements and mobility for 5 minutes',
            durationSeconds: 300,
          ),
          WorkoutStep(
            title: 'Skill Work',
            description: 'Practice double-unders and handstand holds for 10 minutes',
            durationSeconds: 600,
          ),
          WorkoutStep(
            title: 'WOD: AMRAP 20',
            description: 'As Many Rounds As Possible in 20 minutes: 5 Pull-ups, 10 Push-ups, 15 Air Squats',
            durationSeconds: 1200,
          ),
          WorkoutStep(
            title: 'Cool Down',
            description: 'Mobility work and stretching for 5 minutes',
            durationSeconds: 300,
          ),
        ],
      ),
    ];
  }
}