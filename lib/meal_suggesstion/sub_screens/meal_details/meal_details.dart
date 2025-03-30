import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:didpool/components/app_text.dart';

class MealDetailScreen extends StatelessWidget {
  final Map<String, dynamic> meal;
  final Function onAddToLog;

  const MealDetailScreen({
    Key? key,
    required this.meal,
    required this.onAddToLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1926),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1F1926),
        title: Text(
          meal['name'],
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xffE9E3E4),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffE9E3E4)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                
                // Meal image
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff412a51),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.restaurant,
                      color: const Color(0xff0f856f),
                      size: 80.sp,
                    ),
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                // Meal info section
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xff253e3d),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            meal['name'],
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffE9E3E4),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff4023D7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: AppText(
                              meal['type'],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffE9E3E4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      
                      // Nutrition info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNutrientInfo(
                            'Calories', 
                            '${meal['calories']}', 
                            'kcal'
                          ),
                          _buildNutrientInfo(
                            'Protein', 
                            '${meal['protein']}', 
                            'g'
                          ),
                          _buildNutrientInfo(
                            'Carbs', 
                            '${meal['carbs']}', 
                            'g'
                          ),
                          _buildNutrientInfo(
                            'Fat', 
                            '${meal['fat']}', 
                            'g'
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 25.h),
                
                // Ingredients section
                AppText(
                  'Ingredients',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xff352b46),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...(meal['ingredients'] as List).map((ingredient) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.fiber_manual_record,
                                size: 12,
                                color: Color(0xff0f856f),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: AppText(
                                  ingredient,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffE9E3E4),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                
                SizedBox(height: 25.h),
                
                // Instructions section
                AppText(
                  'Instructions',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffE9E3E4),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: const Color(0xff352b46),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...(meal['instructions'] as List).asMap().entries.map((entry) {
                        final index = entry.key;
                        final instruction = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xff0f856f),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: AppText(
                                    '${index + 1}',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: AppText(
                                  instruction,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffE9E3E4),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                
                SizedBox(height: 30.h),
                
                // Add to log button
                GestureDetector(
                  onTap: () {
                    onAddToLog();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      color: const Color(0xff0f856f),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: AppText(
                        'Add to My Log',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildNutrientInfo(String label, String value, String unit) {
    return Column(
      children: [
        AppText(
          label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            AppText(
              value,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff0f856f),
            ),
            AppText(
              unit,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}