import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MealService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Get predefined meal suggestions
  Future<List<Map<String, dynamic>>> getMealSuggestions() async {
    return [
      {
        'id': 'meal1',
        'name': 'Greek Yogurt Bowl',
        'calories': 320,
        'image': 'assets/yogurt.png',
        'type': 'Breakfast',
        'protein': 22,
        'carbs': 30,
        'fat': 12,
        'ingredients': [
          'Greek yogurt (1 cup)',
          'Mixed berries (1/2 cup)',
          'Honey (1 tbsp)',
          'Granola (1/4 cup)',
          'Chia seeds (1 tsp)'
        ],
        'instructions': [
          'Add yogurt to a bowl',
          'Top with berries, granola, and chia seeds',
          'Drizzle with honey'
        ]
      },
      {
        'id': 'meal2',
        'name': 'Grilled Chicken Salad',
        'calories': 410,
        'image': 'assets/salad.png',
        'type': 'Lunch',
        'protein': 35,
        'carbs': 20,
        'fat': 15,
        'ingredients': [
          'Grilled chicken breast (4 oz)',
          'Mixed greens (2 cups)',
          'Cherry tomatoes (1/2 cup)',
          'Cucumber (1/2, sliced)',
          'Avocado (1/4)',
          'Balsamic vinaigrette (2 tbsp)'
        ],
        'instructions': [
          'Slice grilled chicken breast',
          'Toss mixed greens with vegetables',
          'Add chicken on top',
          'Drizzle with balsamic vinaigrette'
        ]
      },
      {
        'id': 'meal3',
        'name': 'Salmon & Vegetables',
        'calories': 480,
        'image': 'assets/salmon.png',
        'type': 'Dinner',
        'protein': 30,
        'carbs': 25,
        'fat': 20,
        'ingredients': [
          'Salmon fillet (5 oz)',
          'Asparagus (1 cup)',
          'Quinoa (1/2 cup, cooked)',
          'Lemon (1/2)',
          'Olive oil (1 tbsp)',
          'Garlic (2 cloves, minced)',
          'Salt and pepper to taste'
        ],
        'instructions': [
          'Season salmon with salt, pepper, and garlic',
          'Bake salmon at 400°F for 12-15 minutes',
          'Steam asparagus until tender',
          'Serve with cooked quinoa',
          'Squeeze lemon over everything'
        ]
      },
      {
        'id': 'meal4',
        'name': 'Protein Smoothie',
        'calories': 280,
        'image': 'assets/smoothie.png',
        'type': 'Snack',
        'protein': 20,
        'carbs': 30,
        'fat': 5,
        'ingredients': [
          'Whey protein powder (1 scoop)',
          'Banana (1 medium)',
          'Almond milk (1 cup)',
          'Spinach (1 cup)',
          'Peanut butter (1 tbsp)',
          'Ice cubes (1/2 cup)'
        ],
        'instructions': [
          'Add all ingredients to blender',
          'Blend until smooth',
          'Pour into glass and enjoy immediately'
        ]
      },
    ];
  }

  // Reset weekly calories tracking
Future<bool> resetWeeklyCalories() async {
  if (currentUserId == null) return false;

  try {
    // 1. Get current date
    final now = DateTime.now();
    final today = now.toIso8601String().split('T')[0];
    
    // 2. Create/update a weekly tracking document
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('weeklyStats')
        .doc(today)
        .set({
      'weekStartDate': today,
      'weekNumber': _getWeekNumber(now),
      'year': now.year,
      'totalCalories': 0,
      'totalProtein': 0,
      'totalCarbs': 0,
      'totalFat': 0,
      'lastResetDate': today,
    });
    
    // 3. Optional: Store previous week's summary for history
    final previousWeekEnd = now.subtract(const Duration(days: 1));
    final lastWeek = _getWeekNumber(previousWeekEnd);
    final lastWeekYear = previousWeekEnd.year;
    
    // Get the stats from previous week
    final weeklyStatsQuery = await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('weeklyStats')
        .where('weekNumber', isEqualTo: lastWeek)
        .where('year', isEqualTo: lastWeekYear)
        .limit(1)
        .get();
    
    // If we have previous week stats, archive them
    if (weeklyStatsQuery.docs.isNotEmpty) {
      final previousWeekStats = weeklyStatsQuery.docs.first.data();
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('weeklyHistory')
          .doc('${lastWeekYear}_week${lastWeek}')
          .set(previousWeekStats);
    }
    
    // 4. Flag today's dailyStats as start of new week
    final todayStatsDoc = await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('dailyStats')
        .doc(today)
        .get();
    
    if (todayStatsDoc.exists) {
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('dailyStats')
          .doc(today)
          .update({
        'isWeekStart': true,
        'weekNumber': _getWeekNumber(now),
      });
    } else {
      // Create today's stats document if it doesn't exist
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('dailyStats')
          .doc(today)
          .set({
        'consumedCalories': 0,
        'protein': 0,
        'carbs': 0,
        'fat': 0,
        'date': today,
        'isWeekStart': true,
        'weekNumber': _getWeekNumber(now),
      });
    }
    
    // 5. Update user document with reset timestamp
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .update({
      'lastWeeklyReset': FieldValue.serverTimestamp(),
      'currentWeekStartDate': today,
    });
    
    return true;
  } catch (e) {
    print('Error in resetWeeklyCalories: $e');
    return false;
  }
}

// Helper method to get ISO week number (1-53)
int _getWeekNumber(DateTime date) {
  // Calculate the ISO week number
  int dayOfYear = int.parse(
      DateFormat('D').format(date)); // 'D' outputs day of year (1-366)
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
  
  // Handle edge cases for week 53/1
  if (woy < 1) {
    // Last week of previous year
    woy = _getWeekNumber(DateTime(date.year - 1, 12, 31));
  } else if (woy > 52) {
    // Check if it's actually week 1 of next year
    final lastDayOfYear = DateTime(date.year, 12, 31);
    if (_getWeekNumber(lastDayOfYear) == 1) {
      woy = 1;
    }
  }
  
  return woy;
}

  // Get recently tracked meals for current user
  Future<List<Map<String, dynamic>>> getRecentlyTrackedMeals() async {
    if (currentUserId == null) return [];

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('trackedMeals')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching tracked meals: $e');
      return [];
    }
  }

  // Track a new meal
  Future<bool> trackMeal(Map<String, dynamic> meal) async {
    if (currentUserId == null) return false;

    try {
      // Add timestamp to meal data
      final trackedMeal = {
        ...meal,
        'timestamp': FieldValue.serverTimestamp(),
        'date': DateTime.now().toIso8601String(),
      };

      // Add to user's tracked meals
      await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('trackedMeals')
          .add(trackedMeal);

      // Update user's total consumed calories for the day
      final today = DateTime.now().toIso8601String().split('T')[0];

      final userDailyStats = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('dailyStats')
          .doc(today)
          .get();

      if (userDailyStats.exists) {
        await _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('dailyStats')
            .doc(today)
            .update({
          'consumedCalories': FieldValue.increment(meal['calories']),
          'protein': FieldValue.increment(meal['protein']),
          'carbs': FieldValue.increment(meal['carbs']),
          'fat': FieldValue.increment(meal['fat']),
        });
      } else {
        await _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('dailyStats')
            .doc(today)
            .set({
          'consumedCalories': meal['calories'],
          'protein': meal['protein'],
          'carbs': meal['carbs'],
          'fat': meal['fat'],
          'date': today,
        });
      }

      return true;
    } catch (e) {
      print('Error tracking meal: $e');
      return false;
    }
  }

  // Get meal details by ID
  Future<Map<String, dynamic>?> getMealDetails(String mealId) async {
    try {
      final meals = await getMealSuggestions();
      return meals.firstWhere((meal) => meal['id'] == mealId);
    } catch (e) {
      print('Error getting meal details: $e');
      return null;
    }
  }

  // Get user's daily calorie goal
  Future<int> getDailyCalorieGoal() async {
    if (currentUserId == null) return 2000; // Default goal

    try {
      final userDoc =
          await _firestore.collection('users').doc(currentUserId).get();

      if (userDoc.exists && userDoc.data()!.containsKey('calorieGoal')) {
        return userDoc.data()!['calorieGoal'];
      } else {
        return 2000; // Default goal
      }
    } catch (e) {
      print('Error fetching calorie goal: $e');
      return 2000; // Default goal on error
    }
  }
}
