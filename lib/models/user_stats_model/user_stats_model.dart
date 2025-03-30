class UserStatsModel {
  final String id;
  final String userId;
  final int weeklyWorkouts;
  final int totalWeeklyGoal;
  final int monthlyWorkoutMinutes;
  final Map<String, double> dailyActivityPercentages;

  UserStatsModel({
    required this.id,
    required this.userId,
    required this.weeklyWorkouts,
    required this.totalWeeklyGoal,
    required this.monthlyWorkoutMinutes,
    required this.dailyActivityPercentages,
  });

  factory UserStatsModel.fromMap(Map<String, dynamic> map, String docId) {
    Map<String, double> dailyActivity = {};
    
    if (map['dailyActivityPercentages'] != null) {
      map['dailyActivityPercentages'].forEach((key, value) {
        dailyActivity[key] = (value as num).toDouble();
      });
    }

    return UserStatsModel(
      id: docId,
      userId: map['userId'] ?? '',
      weeklyWorkouts: map['weeklyWorkouts'] ?? 0,
      totalWeeklyGoal: map['totalWeeklyGoal'] ?? 5,
      monthlyWorkoutMinutes: map['monthlyWorkoutMinutes'] ?? 0,
      dailyActivityPercentages: dailyActivity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'weeklyWorkouts': weeklyWorkouts,
      'totalWeeklyGoal': totalWeeklyGoal,
      'monthlyWorkoutMinutes': monthlyWorkoutMinutes,
      'dailyActivityPercentages': dailyActivityPercentages,
    };
  }

  // Create a new object with updated values
  UserStatsModel copyWith({
    String? id,
    String? userId,
    int? weeklyWorkouts,
    int? totalWeeklyGoal,
    int? monthlyWorkoutMinutes,
    Map<String, double>? dailyActivityPercentages,
  }) {
    return UserStatsModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weeklyWorkouts: weeklyWorkouts ?? this.weeklyWorkouts,
      totalWeeklyGoal: totalWeeklyGoal ?? this.totalWeeklyGoal,
      monthlyWorkoutMinutes: monthlyWorkoutMinutes ?? this.monthlyWorkoutMinutes,
      dailyActivityPercentages: dailyActivityPercentages ?? this.dailyActivityPercentages,
    );
  }
}