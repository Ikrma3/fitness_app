import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaloriesBurnedChart extends StatelessWidget {
  final List<dynamic> data;
  final String view;

  CaloriesBurnedChart({required this.data, required this.view});

  @override
  Widget build(BuildContext context) {
    final yRange = _calculateYRange(data, view);

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
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h, // Adjust height as needed
            child: BarChart(
              BarChartData(
                barGroups: _generateBarGroups(data),
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0.h),
                          child: Text(
                            value.toInt().toString(),
                            style:
                                TextStyle(color: Color.fromRGBO(64, 75, 82, 1)),
                          ),
                        );
                      },
                      reservedSize: 50,
                      interval: (yRange[1] - yRange[0]) / 2,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (view == 'Day') {
                          return Text(
                            _getDayInitial(value.toInt()),
                            style: TextStyle(color: Colors.black),
                          );
                        } else if (view == 'Week') {
                          return Text(
                            (value + 1).toString(),
                            style: TextStyle(color: Colors.black),
                          );
                        } else {
                          return Text(
                            _getMonthShort(value.toInt()),
                            style: TextStyle(color: Colors.black),
                          );
                        }
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
                  horizontalInterval: (yRange[1] - yRange[0]) / 2,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Color.fromRGBO(211, 234, 240, 1),
                      strokeWidth: 1,
                    );
                  },
                ),
                minY: yRange[0],
                maxY: yRange[1],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<dynamic> data) {
    if (view == 'Day') {
      return List.generate(7, (index) {
        double value =
            0.0; // Default value if no data is available for that day

        // Find data corresponding to the current day index
        for (var item in data) {
          int dayOfWeek =
              DateTime.parse(item['date']).weekday % 7; // Get day of week (0-6)

          // Check if the current item corresponds to the current day index
          if (dayOfWeek == index) {
            value = item['caloriesBurned'].toDouble();
            break;
          }
        }

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: index % 2 == 0
                  ? Color.fromRGBO(244, 66, 55, 1)
                  : Color.fromRGBO(245, 99, 74, 1),
              width: 8.w,
            ),
          ],
        );
      });
    } else {
      // For 'Week' and 'Month' views, use the existing logic
      return data.asMap().entries.map((entry) {
        int index = entry.key;
        var item = entry.value;
        double value = item['caloriesBurned'].toDouble();

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: index % 2 == 0
                  ? Color.fromRGBO(244, 66, 55, 1)
                  : Color.fromRGBO(245, 99, 74, 1),
              width: 8.w,
            ),
          ],
        );
      }).toList();
    }
  }

  String _getDayInitial(int index) {
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return days[index % days.length];
  }

  String _getMonthShort(int index) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[index % months.length];
  }

  List<double> _calculateYRange(List<dynamic> data, String view) {
    if (data.isEmpty) {
      if (view == 'Day') {
        return [0, 1000];
      } else if (view == 'Week') {
        return [1000, 10000];
      } else {
        return [10000, 100000];
      }
    }

    double min = double.infinity;
    double max = double.negativeInfinity;

    for (var item in data) {
      double value = item['caloriesBurned'].toDouble();
      if (value < min) {
        min = value;
      }
      if (value > max) {
        max = value;
      }
    }

    if (min == double.infinity || max == double.negativeInfinity) {
      if (view == 'Day') {
        return [0, 1000];
      } else if (view == 'Week') {
        return [1000, 10000];
      } else {
        return [10000, 100000];
      }
    }

    double rangeMin = (min ~/ 100) * 100;
    double rangeMax = ((max / 100).ceil() + 1) * 100;

    if (view == 'Week') {
      rangeMin = (min ~/ 1000) * 1000;
      rangeMax = ((max / 1000).ceil() + 1) * 1000;
    } else if (view == 'Month') {
      rangeMin = (min ~/ 10000) * 10000;
      rangeMax = ((max / 10000).ceil() + 1) * 10000;
    }

    return [rangeMin, rangeMax];
  }
}
