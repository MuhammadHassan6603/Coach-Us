import 'package:didpool/meal_suggesstion/sub_screens/meal_details/meal_details.dart';
import 'package:didpool/services/meal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';

class MealSuggestionTracker extends StatefulWidget {
  const MealSuggestionTracker({super.key});

  @override
  State<MealSuggestionTracker> createState() => _MealSuggestionTrackerState();
}

class _MealSuggestionTrackerState extends State<MealSuggestionTracker> {
  final MealService _mealService = MealService();
  
  List<Map<String, dynamic>> mealSuggestions = [];
  List<Map<String, dynamic>> recentlyTrackedMeals = [];
  
  int dailyCalorieGoal = 2000;
  int consumedCalories = 0;
  bool isLoading = true;
  
  String currentMealType = "All";
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      // Load meal suggestions
      final suggestions = await _mealService.getMealSuggestions();
      
      // Load recently tracked meals
      final trackedMeals = await _mealService.getRecentlyTrackedMeals();
      
      // Load daily calorie goal
      final calorieGoal = await _mealService.getDailyCalorieGoal();
      
      // Calculate consumed calories from today's tracked meals
      int todayCalories = 0;
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      for (var meal in trackedMeals) {
        final mealDate = meal['date']?.split('T')[0];
        if (mealDate == today) {
          todayCalories += meal['calories'] as int;
        }
      }
      
      setState(() {
        mealSuggestions = suggestions;
        recentlyTrackedMeals = trackedMeals;
        dailyCalorieGoal = calorieGoal;
        consumedCalories = todayCalories;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  
  void _viewMealDetails(Map<String, dynamic> meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
          onAddToLog: () => _trackMeal(meal),
        ),
      ),
    );
  }
  
  Future<void> _trackMeal(Map<String, dynamic> meal) async {
    try {
      final success = await _mealService.trackMeal(meal);
      
      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${meal["name"]} added to your log')),
        );
        
        // Reload data
        _loadData();
      }
    } catch (e) {
      print('Error tracking meal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add meal to log')),
      );
    }
  }

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
          'Meal Ideas & Calories',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff0f856f)))
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildCalorieTracker(),
                      SizedBox(height: 30.h),
                      
                      Row(
                        children: [
                          AppText(
                            'Suggested Meals',
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
                            child: Center(
                              child: AppText(
                                'See All',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffE9E3E4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildMealSuggestions(),
                      
                      SizedBox(height: 30.h),
                      AppText(
                        'Recently Tracked',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffE9E3E4),
                      ),
                      SizedBox(height: 15.h),
                      _buildRecentlyTracked(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
  
  Widget _buildCalorieTracker() {
    final double progress = consumedCalories / dailyCalorieGoal;
    
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff253e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Calories Consumed',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffE9E3E4),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      AppText(
                        '$consumedCalories',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0f856f),
                      ),
                      AppText(
                        ' / $dailyCalorieGoal kcal',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              CircularProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[800],
                color: const Color(0xff0f856f),
                strokeWidth: 8,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey[800],
            color: const Color(0xff0f856f),
            minHeight: 10.h,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSuggestions() {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mealSuggestions.length,
        itemBuilder: (context, index) {
          final meal = mealSuggestions[index];
          
          return Container(
            width: 160.w,
            margin: EdgeInsets.only(right: 15.w),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: const Color(0xff253e3d),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff412a51),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.restaurant,
                      color: const Color(0xff0f856f),
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                AppText(
                  meal['name'],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 5.h),
                AppText(
                  '${meal['calories']} kcal • ${meal['type']}',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => _viewMealDetails(meal),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xff0f856f),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: AppText(
                        'View Meal',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildRecentlyTracked() {
    if (recentlyTrackedMeals.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(
          child: AppText(
            'No meals tracked yet',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      );
    }
    
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: recentlyTrackedMeals.length,
      itemBuilder: (context, index) {
        final meal = recentlyTrackedMeals[index];
        final date = meal['timestamp'] != null 
            ? DateTime.fromMillisecondsSinceEpoch(
                meal['timestamp'].seconds * 1000, 
                isUtc: true)
            : DateTime.now();
        
        final timeFormatted = '${_formatDate(date)} • ${_formatTime(date)}';
        
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          decoration: BoxDecoration(
            color: const Color(0xff352b46),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: const Color(0xff253e3d),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: Color(0xff0f856f),
                ),
              ),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    meal['name'],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffE9E3E4),
                  ),
                  SizedBox(height: 5.h),
                  AppText(
                    timeFormatted,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
              const Spacer(),
              AppText(
                '${meal['calories']} kcal',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff0f856f),
              ),
            ],
          ),
        );
      },
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return '${date.month}/${date.day}';
    }
  }
  
  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}