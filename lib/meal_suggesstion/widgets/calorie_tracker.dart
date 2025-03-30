// BUILD MEAL TYPE FILTER

// Widget _buildMealTypeFilter() {
//     final mealTypes = ['All', 'Breakfast', 'Lunch', 'Dinner', 'Snack'];
    
//     return SizedBox(
//       height: 40.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: mealTypes.length,
//         itemBuilder: (context, index) {
//           final isSelected = mealTypes[index] == currentMealType;
          
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 currentMealType = mealTypes[index];
//               });
//             },
//             child: Container(
//               margin: EdgeInsets.only(right: 15.w),
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xff0f856f) : const Color(0xff253e3d),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Center(
//                 child: AppText(
//                   mealTypes[index],
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xffE9E3E4),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }


//**************************************************//



// BUILD CALORIE TRACKER 

// Widget _buildCalorieTracker() {
//     double progress = consumedCalories / dailyCalorieGoal;
    
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
//       decoration: BoxDecoration(
//         color: const Color(0xff412a51),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppText(
//                     'Daily Calories',
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xffE9E3E4),
//                   ),
//                   SizedBox(height: 5.h),
//                   AppText(
//                     '$consumedCalories / $dailyCalorieGoal kcal',
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xff4023D7),
//                   ),
//                 ],
//               ),
//               Container(
//                 height: 50.h,
//                 width: 50.w,
//                 decoration: BoxDecoration(
//                   color: const Color(0xff253e3d),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.restaurant_menu,
//                   color: Color(0xff0f856f),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15.h),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: LinearProgressIndicator(
//               value: progress,
//               backgroundColor: const Color(0xff253e3d),
//               valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff0f856f)),
//               minHeight: 10.h,
//             ),
//           ),
//           SizedBox(height: 15.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNutrientInfo('Protein', '65g', const Color(0xff4023D7)),
//               _buildNutrientInfo('Carbs', '120g', const Color(0xff0f856f)),
//               _buildNutrientInfo('Fat', '40g', const Color(0xffA05193)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildNutrientInfo(String label, String value, Color color) {
//     return Column(
//       children: [
//         AppText(
//           label,
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w500,
//           color: const Color(0xffE9E3E4),
//         ),
//         SizedBox(height: 5.h),
//         AppText(
//           value,
//           fontSize: 14.sp,
//           fontWeight: FontWeight.bold,
//           color: color,
//         ),
//       ],
//     );
//   }


//*******************************************//