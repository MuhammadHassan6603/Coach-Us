import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';

class WaterIntakeWidget extends StatelessWidget {
  final int currentIntake;
  final int goalIntake;
  final Function(int) onIntakeChanged;

  const WaterIntakeWidget({
    Key? key,
    required this.currentIntake,
    required this.goalIntake,
    required this.onIntakeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xff2D2535),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.water_drop,
                color: Colors.blue,
                size: 24.sp,
              ),
              SizedBox(width: 10.w),
              AppText(
                'Water Intake',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xffE9E3E4),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppText(
                  '$currentIntake/$goalIntake glasses',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(goalIntake, (index) {
              final bool isFilled = index < currentIntake;
              return GestureDetector(
                onTap: () => onIntakeChanged(index + 1),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 29.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: isFilled ? Colors.blue : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                      bottomLeft: Radius.circular(5.r),
                      bottomRight: Radius.circular(5.r),
                    ),
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: isFilled ? Colors.white : Colors.blue.withOpacity(0.5),
                    size: 16.sp,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 20.h),
          
          
          Container(
            width: double.infinity,
            height: 10.h,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: currentIntake / goalIntake,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          
          
          Row(
            children: [
              Icon(
                Icons.tips_and_updates,
                color: Colors.amber,
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AppText(
                  'Drink water regularly throughout the day for optimal hydration',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          
          
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () => onIntakeChanged(currentIntake < goalIntake ? currentIntake + 1 : currentIntake),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  AppText(
                    'Add Glass',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}