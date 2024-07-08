import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/settings.dart';

class GoalScreen extends StatefulWidget {
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  Map<String, dynamic> goalsData = {};
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadGoalsData();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DairyScreen()),
        );
        _currentIndex = 0;
      } else if (_currentIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanScreen()),
        );
        _currentIndex = 0;
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  Future<void> loadGoalsData() async {
    final String response =
        await rootBundle.loadString('lib/json files/goal.json');
    final data = await json.decode(response);
    setState(() {
      goalsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (goalsData.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
          backgroundColor: Color.fromRGBO(245, 250, 255, 1),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Goals",
              style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter'),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 20.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Starting Weight",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            goalsData['startingWeight'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)),
                          ),
                        ],
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Current Weight",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            goalsData['currentWeight'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)),
                          ),
                        ],
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            "Goal Weight",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          Text(
                            goalsData['goalWeight'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)),
                          ),
                        ],
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text("Weekly Goal",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500)),
                          Spacer(),
                          Text(
                            goalsData['weeklyGoal'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)),
                          ),
                        ],
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text("Activity Level",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500)),
                          Spacer(),
                          Text(
                            goalsData['activityLevel'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                // New Container
                Container(
                  margin: EdgeInsets.only(top: 20.0.h),
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 20.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nutrition Goals",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter'),
                      ),
                      ListTile(
                        title: Text(
                          "Calories, Carbs, Protein and Fat Goals",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        subtitle: Text(
                          "Customize your default or daily goals",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontFamily: 'Inter'),
                        ),
                        onTap: () {
                          // Handle navigation or action here
                        },
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      ListTile(
                        title: Text(
                          "Calories Goals by Meal",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        subtitle: Text(
                          "Stay on track with a calorie goal for each meal",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontFamily: 'Inter'),
                        ),
                        onTap: () {
                          // Handle navigation or action here
                        },
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      ListTile(
                        title: Text(
                          "Show Carbs, Protein and Fat by Meal",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        subtitle: Text(
                          "View carbs, protein and by gram or percent.",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontFamily: 'Inter'),
                        ),
                        onTap: () {
                          // Handle navigation or action here
                        },
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      ListTile(
                        title: Text(
                          "Additional Nutrients Goals",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter'),
                        ),
                        onTap: () {
                          // Handle navigation or action here
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0.h),
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 20.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fitness Goals",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Row(
                          children: [
                            Text(
                              "Workout/Week",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter'),
                            ),
                            Spacer(),
                            Text(
                              goalsData['workout/week'].toString(),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter'),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Row(
                          children: [
                            Text("Minutes/Workout",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter')),
                            Spacer(),
                            Text(goalsData['minutes/workout'].toString(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter'))
                          ],
                        ),
                      ),
                      Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                      ListTile(
                        title: Text("Exercise Calories",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter')),
                        subtitle: Text(
                            "Decide whether to adjust daily goals when you exercise",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontFamily: 'Inter')),
                        onTap: () {
                          // Handle navigation or action here
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
          ));
    }
  }
}
