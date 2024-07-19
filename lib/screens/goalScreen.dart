import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

  Future<void> saveGoalsData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/goal.json');
    await file.writeAsString(json.encode(goalsData));
  }

  @override
  Widget build(BuildContext context) {
    if (goalsData.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            "Goals",
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditableRow(
                      label: "Starting Weight",
                      value: goalsData['startingWeight'],
                      onChanged: (newValue) {
                        setState(() {
                          goalsData['startingWeight'] = newValue;
                          saveGoalsData();
                        });
                      },
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    SizedBox(height: 10.h),
                    EditableRow(
                      label: "Current Weight",
                      value: goalsData['currentWeight'],
                      onChanged: (newValue) {
                        setState(() {
                          goalsData['currentWeight'] = newValue;
                          saveGoalsData();
                        });
                      },
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    SizedBox(height: 10.h),
                    EditableRow(
                      label: "Goal Weight",
                      value: goalsData['goalWeight'],
                      onChanged: (newValue) {
                        setState(() {
                          goalsData['goalWeight'] = newValue;
                          saveGoalsData();
                        });
                      },
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    SizedBox(height: 10.h),
                    EditableRow(
                      label: "Weekly Goal",
                      value: goalsData['weeklyGoal'],
                      onChanged: (newValue) {
                        setState(() {
                          goalsData['weeklyGoal'] = newValue;
                          saveGoalsData();
                        });
                      },
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    SizedBox(height: 10.h),
                    EditableRow(
                      label: "Activity Level",
                      value: goalsData['activityLevel'],
                      onChanged: (newValue) {
                        setState(() {
                          goalsData['activityLevel'] = newValue;
                          saveGoalsData();
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0.h),
                color: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nutrition Goals",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Calories, Carbs, Protein and Fat Goals",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      subtitle: Text(
                        "Customize your default or daily goals",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
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
                          fontFamily: 'Inter',
                        ),
                      ),
                      subtitle: Text(
                        "Stay on track with a calorie goal for each meal",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
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
                          fontFamily: 'Inter',
                        ),
                      ),
                      subtitle: Text(
                        "View carbs, protein and by gram or percent.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
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
                          fontFamily: 'Inter',
                        ),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fitness Goals",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Row(
                        children: [
                          Text(
                            "Workout/Week",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Spacer(),
                          Text(
                            goalsData['workout/week'].toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Row(
                        children: [
                          Text(
                            "Minutes/Workout",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Spacer(),
                          Text(
                            goalsData['minutes/workout'].toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Color.fromRGBO(211, 234, 240, 1)),
                    ListTile(
                      title: Text(
                        "Exercise Calories",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      subtitle: Text(
                        "Decide whether to adjust daily goals when you exercise",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Inter',
                        ),
                      ),
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
        ),
      );
    }
  }
}

class EditableRow extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  EditableRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        SizedBox(
          width: 100.w,
          child: TextFormField(
            initialValue: value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: Color.fromRGBO(21, 109, 149, 1),
            ),
            onFieldSubmitted: onChanged,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
