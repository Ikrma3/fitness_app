import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

class WeightTrackingChart extends StatelessWidget {
  final List<dynamic> data;
  final String view;

  WeightTrackingChart({required this.data, required this.view});

  @override
  Widget build(BuildContext context) {
    final yRange = _calculateYRange(data, view);

    return Container(
      padding: EdgeInsets.all(20.w.h),
      decoration: BoxDecoration(
        gradient: AppColors.ChartgetGradient(context),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h),
            child: Row(
              children: [
                Text(
                  'Weight tracking',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppin'),
                ),
                Spacer(),
                Text(
                  'History',
                  style: TextStyle(
                      color: AppColors.getSubtitleColor(context),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppin'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 28.h),
              child: LineChart(
                LineChartData(
                  lineBarsData: _generateLineBarsData(data),
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
                            ),
                          );
                        },
                        reservedSize: 50,
                        interval: (yRange[1] - yRange[0]) /
                            4, // Dynamic interval for 5 lines
                      ),
                    ),
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (view == 'Day') {
                          return Text(
                            _getDayInitial(value.toInt()),
                          );
                        } else if (view == 'Week') {
                          return Text(
                            (value + 1).toString(),
                          );
                        } else {
                          return Text(
                            _getMonthShort(value.toInt()),
                          );
                        }
                      },
                    )),
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
                    horizontalInterval: (yRange[1] - yRange[0]) /
                        4, // Dynamic interval for 5 lines
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
          ),
        ],
      ),
    );
  }

  List<LineChartBarData> _generateLineBarsData(List<dynamic> data) {
    List<FlSpot> spots = [];

    for (var i = 0; i < data.length; i++) {
      var item = data[i];
      double xValue;
      double value = item['weight'].toDouble();

      if (view == 'Day') {
        // For 'Day' view, calculate day of week based on the date
        int dayOfWeek = DateTime.parse(item['date']).weekday % 7;
        xValue = dayOfWeek.toDouble();
      } else if (view == 'Week') {
        // For 'Week' view, use labels S, M, T, W, T, F, S
        xValue = i.toDouble();
      } else {
        // For 'Month' view, use month names Jan, Feb, Mar, ...
        xValue = i.toDouble();
      }

      spots.add(FlSpot(xValue, value));
    }

    return [
      LineChartBarData(
        spots: spots,
        isCurved: true,
        color: Color.fromRGBO(21, 109, 149, 1),
        barWidth: 4.w,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            radius: 8.r,
            color: Color.fromRGBO(21, 109, 149, 1), // Dot color
            strokeWidth: 2,
            strokeColor: Colors.white,
          ),
        ),
        belowBarData: BarAreaData(show: false),
      ),
    ];
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
      return [50, 60]; // Default range if no data is available
    }

    double min = double.infinity;
    double max = double.negativeInfinity;

    for (var item in data) {
      double value = item['weight'].toDouble();
      if (value < min) {
        min = value;
      }
      if (value > max) {
        max = value;
      }
    }

    if (min == double.infinity || max == double.negativeInfinity) {
      return [50, 60]; // Default range if data is invalid
    }

    min = (min * 10).floorToDouble() / 10; // Round down to nearest tenth
    max = (max * 10).ceilToDouble() / 10; // Round up to nearest tenth

    double rangeMin = min - 2;
    double rangeMax = max + 2;

    double interval;
    if (view == 'Day') {
      interval = 1;
    } else if (view == 'Week') {
      interval = 2;
    } else {
      interval = 5;
    }

    rangeMin = (rangeMin / interval).floorToDouble() * interval;
    rangeMax = (rangeMax / interval).ceilToDouble() * interval;

    return [rangeMin, rangeMax];
  }
}
