import 'package:cloud_firestore/cloud_firestore.dart';

class LoggedWorkoutModel {
  final String id;
  final String workoutId;
  final String workoutName;
  final DateTime dateTime;
  final String duration;
  final int durationMinutes;
  final int calories;
  final String userId;

  LoggedWorkoutModel({
    required this.id,
    required this.workoutId,
    required this.workoutName,
    required this.dateTime,
    required this.duration,
    required this.durationMinutes,
    required this.calories,
    required this.userId,
  });

  factory LoggedWorkoutModel.fromMap(Map<String, dynamic> map, String docId) {
    return LoggedWorkoutModel(
      id: docId,
      workoutId: map['workoutId'] ?? '',
      workoutName: map['workoutName'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      duration: map['duration'] ?? '',
      durationMinutes: map['durationMinutes'] ?? 0,
      calories: map['calories'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'workoutName': workoutName,
      'dateTime': Timestamp.fromDate(dateTime),
      'duration': duration,
      'durationMinutes': durationMinutes,
      'calories': calories,
      'userId': userId,
    };
  }

  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    
    final workoutDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (workoutDate == today) {
      return 'Today';
    } else if (workoutDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${dateTime.day} ${_getMonthAbbreviation(dateTime.month)}';
    }
  }

  String get formattedTime {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  String _getMonthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}