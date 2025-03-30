import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class LevelSelector extends StatelessWidget {
  final String selectedLevel;
  final Function(String) onLevelSelected;

  const LevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final levels = ['Beginner', 'Intermediate', 'Advanced'];
    
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final isSelected = levels[index] == selectedLevel;
          
          return GestureDetector(
            onTap: () {
              onLevelSelected(levels[index]);
            },
            child: Container(
              margin: EdgeInsets.only(right: 15.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff4023D7) : const Color(0xff352b46),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: AppText(
                  levels[index],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffE9E3E4),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}