import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
