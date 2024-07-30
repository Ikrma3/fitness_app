import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitness/components/colours.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MacroExplorer extends StatefulWidget {
  @override
  _MacroExplorerState createState() => _MacroExplorerState();
}

class _MacroExplorerState extends State<MacroExplorer> {
  List<dynamic> nutrientData = [];
  int currentIndex = 0;
  DateTime _selectedDate = DateTime.now();

  Color proteinColor = Color.fromRGBO(21, 109, 149, 1);
  Color carbsColor = Color.fromRGBO(244, 66, 55, 1);
  Color fatColor = Color.fromRGBO(250, 155, 49, 1);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('lib/json files/macrosExplorer.json');
    setState(() {
      nutrientData = json.decode(data);
      _updateIndexByDate(_selectedDate); // Update index based on initial date
    });
  }

  void _updateIndexByDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    for (int i = 0; i < nutrientData.length; i++) {
      if (nutrientData[i]['date'] == formattedDate) {
        setState(() {
          currentIndex = i;
        });
        break;
      }
    }
  }

  bool _isToday(String date) {
    DateTime today = DateTime.now();
    DateTime parsedDate = DateTime.parse(date);

    return today.year == parsedDate.year &&
        today.month == parsedDate.month &&
        today.day == parsedDate.day;
  }

  void _navigateDate(int direction) {
    setState(() {
      currentIndex += direction;
      if (currentIndex < 0) {
        currentIndex = 0;
      } else if (currentIndex >= nutrientData.length) {
        currentIndex = nutrientData.length - 1;
      }
      _selectedDate = DateTime.parse(nutrientData[currentIndex]['date']);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2030, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateIndexByDate(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (nutrientData.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Nutrition')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    var currentData = nutrientData[currentIndex];
    DateTime currentDate = DateTime.parse(currentData['date']);
    String displayDate = _isToday(currentData['date'])
        ? 'Today'
        : DateFormat('dd/MM/yyyy').format(currentDate);

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0.w.h),
          child: Column(
            children: [
              Container(
                color: AppColors.getBackgroundColor(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                      onPressed: () => _navigateDate(1),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Column(
                            children: [
                              Text('Day View',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color:
                                          AppColors.getSubtitleColor(context),
                                      fontFamily: 'Inter')),
                              Text(displayDate,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                      onPressed: () => _navigateDate(-1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.getGradient(context),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: Column(
                    children: [
                      buildProgressIndicators(currentData),
                      SizedBox(
                        height: 40.h,
                      ),
                      buildNutritionGoals(currentData),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.getGradient(context),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: buildFoodSection("Food Highest in Protein",
                      currentData['foods']['highestProtein']),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.getGradient(context),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: buildFoodSection("Food Highest in Carbohydrates",
                      currentData['foods']['highestCarbs']),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.getGradient(context),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: buildFoodSection("Food Highest in Fat",
                      currentData['foods']['highestFat']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgressIndicators(Map<String, dynamic> currentData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCircularIndicator(
          currentData['nutrition']['protein']['current'],
          currentData['nutrition']['protein']['goal'],
          "Protein",
          proteinColor,
        ),
        buildCircularIndicator(
          currentData['nutrition']['carbs']['current'],
          currentData['nutrition']['carbs']['goal'],
          "Carbs",
          carbsColor,
        ),
        buildCircularIndicator(
          currentData['nutrition']['fats']['current'],
          currentData['nutrition']['fats']['goal'],
          "Fats",
          fatColor,
        ),
      ],
    );
  }

  Widget buildCircularIndicator(
      int current, int goal, String label, Color col) {
    double percentage = (current / goal).clamp(0.0, 1.0);
    return CircularPercentIndicator(
      radius: 40.r,
      lineWidth: 11.0.w,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${current}",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter'),
          ),
          Text(
            'g',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter'),
          )
        ],
      ),
      progressColor: col,
      backgroundColor: Color.fromRGBO(211, 234, 240, 1),
      footer: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              fontFamily: 'Inter',
            )),
      ),
    );
  }

  Widget buildNutritionGoals(Map<String, dynamic> currentData) {
    return Column(
      children: [
        buildGoalRow(
          "Protein",
          proteinColor,
          currentData['nutrition']['protein']['current'],
          currentData['nutrition']['protein']['goal'],
        ),
        buildGoalRow(
          "Carbohydrates",
          carbsColor,
          currentData['nutrition']['carbs']['current'],
          currentData['nutrition']['carbs']['goal'],
        ),
        buildGoalRow(
          "Fats",
          fatColor,
          currentData['nutrition']['fats']['current'],
          currentData['nutrition']['fats']['goal'],
        ),
      ],
    );
  }

  Widget buildGoalRow(String label, Color color, int current, int goal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 13.w, height: 13.h, color: color),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter'),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Text(
          "${current}g of $goal",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
        ),
      ],
    );
  }

  Widget buildFoodSection(String title, List<dynamic> foods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.sp,
                  fontFamily: 'Inter')),
        ),
        Divider(),
        Container(
          padding: EdgeInsets.all(8.0.w.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          child: Column(
            children: foods.map((food) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food['name'],
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                    Text("${food['value']}",
                        style: TextStyle(fontSize: 17, fontFamily: 'Inter')),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
