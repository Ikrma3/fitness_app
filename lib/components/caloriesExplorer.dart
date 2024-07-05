import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myfitness/components/customProgressIndicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaloriesExplorer extends StatefulWidget {
  @override
  _CaloriesExplorerState createState() => _CaloriesExplorerState();
}

class _CaloriesExplorerState extends State<CaloriesExplorer> {
  Map<String, dynamic> _data = {};
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response =
        await rootBundle.loadString('lib/json files/caloriesExplorer.json');
    final data = await json.decode(response);
    setState(() {
      _data = data;
    });
  }

  bool _isToday(String date) {
    DateTime today = DateTime.now();
    DateTime parsedDate =
        DateTime.parse(date); // Assuming date is in ISO 8601 format

    return today.year == parsedDate.year &&
        today.month == parsedDate.month &&
        today.day == parsedDate.day;
  }

  void _navigateDate(int direction) {
    setState(() {
      _currentIndex += direction;
      if (_currentIndex < 0) {
        _currentIndex = 0;
      } else if (_currentIndex >= _data['dates'].length) {
        _currentIndex = _data['dates'].length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final dateData = _data['dates'][_currentIndex];
    final summary = dateData['summary'];
    final meals = dateData['meals'];
    final foods = dateData['foods'];

    // Prepare segments for the custom indicator
    List<Segment> indicatorSegments = meals.map<Segment>((meal) {
      Color color = _getMealColor(meal['name']);
      double percentage = meal['percentage'].toDouble();
      return Segment(color: color, percentage: percentage);
    }).toList();

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.w.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => _navigateDate(1),
                  ),
                  Column(
                    children: [
                      Text('Day View',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                      Text(
                          _isToday(dateData['date'])
                              ? 'Today'
                              : dateData['date'],
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter')),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => _navigateDate(-1),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.w.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  CircularSegmentProgressIndicator(
                    segments: indicatorSegments,
                    radius: 67.5.r,
                    lineWidth: 13.0.w,
                    animation: true,
                  ),
                  SizedBox(height: 16.h),
                  // Dividing meals into two rows with two columns each
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildMealItem(meals[0]),
                            _buildMealItem(meals[1]),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _buildMealItem(meals[2]),
                            _buildMealItem(meals[3]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Calories",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                      Text("${summary['total_calories']}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Consumed",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                      Text("${summary['consumed']}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Burned",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                      Text("${summary['burned']}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: 'Inter')),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Food Highest in Calories",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter')),
                  SizedBox(height: 8.h),
                  ...foods.map<Widget>((food) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(food['name'],
                              style: TextStyle(
                                  fontSize: 16.sp, fontFamily: 'Inter')),
                          Text("${food['calories']}",
                              style: TextStyle(
                                  fontSize: 16.sp, fontFamily: 'Inter')),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMealColor(String mealName) {
    switch (mealName) {
      case 'Breakfast':
        return Color.fromRGBO(250, 155, 49, 1);
      case 'Dinner':
        return Color.fromRGBO(108, 13, 143, 1);
      case 'Lunch':
        return Color.fromRGBO(236, 55, 98, 1);
      case 'Snacks':
        return Color.fromRGBO(21, 109, 149, 1);
      default:
        return Colors.black;
    }
  }

  Widget _buildMealItem(Map<String, dynamic> meal) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          color: _getMealColor(meal['name']),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${meal['name']}",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600)),
            Text("${meal['percentage']}% (${meal['calories']} cal)",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(102, 102, 102, 1))),
          ],
        ),
        SizedBox(
          height: 60.h,
        ),
      ],
    );
  }
}
