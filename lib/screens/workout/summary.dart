import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/charts/summaryChart.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/screens/workout/workoutDetails.dart';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  Map<String, dynamic>? _summaryData;

  @override
  void initState() {
    super.initState();
    _loadSummaryData();
  }

  Future<void> _loadSummaryData() async {
    String jsonString =
        await rootBundle.loadString('lib/json files/summary.json');
    setState(() {
      _summaryData = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_summaryData == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var workout = _summaryData!['workout'];
    var caloriesBurned = workout['caloriesBurned'];

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        surfaceTintColor: AppColors.getAppbarColor(context),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutDetails()),
              );
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Summary',
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Workout",
                style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppin'),
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildWorkoutFrame(workout),
              SizedBox(height: 20.h),
              _buildWorkoutContainer(workout),
              SizedBox(height: 20.h),
              _buildCaloriesBurnedChart(caloriesBurned),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutFrame(Map<String, dynamic> workout) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.all(8.w.h),
      decoration: BoxDecoration(
          gradient: AppColors.getFrameGradient(context),
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                workout['image'],
                width: 63.w,
                height: 50.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout['title'],
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppin'),
                  ),
                  Text(
                    workout['time'],
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.getSummaryText(context),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutContainer(Map<String, dynamic> workout) {
    return Container(
      padding: EdgeInsets.all(16.w.h),
      decoration: BoxDecoration(
        gradient: AppColors.getGradient(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWorkoutDetail('Total time', workout['totalTime']),
              Spacer(),
              _buildWorkoutDetail(
                  'Avg Heart Rate', '${workout['avgHeartRate']} bpm'),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWorkoutDetail(
                  'Active Calories', '${workout['activeCalories']} kcal'),
              Spacer(),
              _buildWorkoutDetail(
                  'Total Calories', '${workout['totalCalories']} kcal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutDetail(String title, String value) {
    final splitValue = _splitValueText(value);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: splitValue[0],
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppin',
                  ),
                ),
                TextSpan(
                  text: splitValue[1],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'OpenSans',
                    color: AppColors.getSummaryText(context),
                  ),
                ),
              ],
            ),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.getSummaryText(context),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'OpenSans')),
        ],
      ),
    );
  }

  List<String> _splitValueText(String value) {
    final regex = RegExp(r'^(\d+)([a-zA-Z ]+)?$');
    final match = regex.firstMatch(value);
    if (match != null) {
      return [match.group(1) ?? '', match.group(2) ?? ''];
    }
    return [value, ''];
  }

  Widget _buildCaloriesBurnedChart(Map<String, dynamic> caloriesBurned) {
    List<int> data = [];
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    for (var day in days) {
      data.add(caloriesBurned[day]);
    }

    return SummaryChart(caloriesBurned: data);
  }
}
