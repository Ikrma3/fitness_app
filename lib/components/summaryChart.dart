import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryChart extends StatelessWidget {
  final List<int> caloriesBurned;

  SummaryChart({required this.caloriesBurned});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Text(
              'Calories burned',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppin'),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 200.h, // Adjust height as needed
            child: BarChart(
              BarChartData(
                barGroups: _generateBarGroups(caloriesBurned),
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0.w),
                          child: Text(
                            value.toInt().toString(),
                            style:
                                TextStyle(color: Color.fromRGBO(64, 75, 82, 1)),
                          ),
                        );
                      },
                      reservedSize: 50,
                      interval: 500,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _getDayInitial(value.toInt()),
                          style: TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 500,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Color.fromRGBO(211, 234, 240, 1),
                      strokeWidth: 1,
                    );
                  },
                ),
                minY: 0,
                maxY: 1000,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<int> data) {
    return List.generate(7, (index) {
      double value = data[index].toDouble();
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: index % 2 == 0
                ? Color.fromRGBO(244, 66, 55, 1)
                : Color.fromRGBO(245, 99, 74, 1),
            width: 8.w,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(8.r)), // Rounded top
          ),
        ],
      );
    });
  }

  String _getDayInitial(int index) {
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return days[index % days.length];
  }
}
