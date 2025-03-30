import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/components/app_text.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthMetricsChart extends StatelessWidget {
  final List<Map<String, dynamic>> weeklyData;

  const HealthMetricsChart({
    Key? key,
    required this.weeklyData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final int maxSteps = weeklyData
        .map((data) => data['steps'] as int)
        .reduce((max, steps) => steps > max ? steps : max);
    
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
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xff4023D7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.bar_chart,
                  color: const Color(0xff4023D7),
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 10.w),
              AppText(
                'Weekly Steps',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xffE9E3E4),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xff4023D7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.insights,
                      color: const Color(0xff4023D7),
                      size: 14.sp,
                    ),
                    SizedBox(width: 5.w),
                    AppText(
                      'Analytics',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff4023D7),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxSteps * 1.2, 
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    
                    tooltipPadding: EdgeInsets.all(8.w),
                    tooltipMargin: 8.h,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklyData[groupIndex]['steps']} steps',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          
                          child: AppText(
                            weeklyData[value.toInt()]['day'],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  weeklyData.length,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: weeklyData[index]['steps'].toDouble(),
                        color: const Color(0xff4023D7),
                        width: 25.w,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.r),
                          topRight: Radius.circular(5.r),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxSteps * 1.2,
                          color: const Color(0xff1F1926),
                        ),
                      ),
                    ],
                  ),
                ),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem(
                'Total',
                '${weeklyData.fold<int>(0, (sum, item) => sum + (item['steps'] as int))}',
                Icons.summarize,
              ),
              _buildSummaryItem(
                'Average',
                '${(weeklyData.fold<int>(0, (sum, item) => sum + (item['steps'] as int)) / 4).round()}',
                Icons.show_chart,
              ),
              _buildSummaryItem(
                'Best',
                '${weeklyData.map((e) => e['steps'] as int).reduce((a, b) => a > b ? a : b)}',
                Icons.emoji_events,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: Colors.grey,
            ),
            SizedBox(width: 5.w),
            AppText(
              label,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ],
        ),
        SizedBox(height: 5.h),
        AppText(
          value,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xffE9E3E4),
        ),
      ],
    );
  }
}