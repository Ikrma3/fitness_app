import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myfitness/components/caloriesBurnedChart.dart';
import 'package:myfitness/components/checkBox.dart';
import 'package:myfitness/components/reportFragment.dart';
import 'dart:convert'; // Add this import
import 'package:flutter/services.dart' show rootBundle; // Add this import
import 'package:myfitness/components/stepsReportChart.dart';
import 'package:myfitness/components/weightTrackingChart.dart';

class WeeklyReportScreen extends StatefulWidget {
  @override
  _WeeklyReportScreenState createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends State<WeeklyReportScreen> {
  int _currentMonthIndex = 0; // Track current month index
  String _selectedView = 'Day';
  List<int> _selectedDayIndices = []; // List to track selected indices
  late List<DateTime> currentMonthDates;
  bool dAys = true; // Control visibility of dates
  late Map<String, dynamic> jsonData; // Add this field
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    // Initialize currentMonthDates
    currentMonthDates = _getDatesForMonth();
  }

  Future<void> _loadJsonData() async {
    // Load the JSON data
    String jsonString =
        await rootBundle.loadString('lib/json files/report.json');
    setState(() {
      jsonData = json.decode(jsonString);
      isLoading = false; // Data has been loaded
    });
  }

  List<DateTime> _getDatesForMonth() {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    if (month > 12) {
      year += month ~/ 12;
      month %= 12;
    }
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    return List.generate(
        daysInMonth, (index) => firstDayOfMonth.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dayFormat = DateFormat.E();
    DateFormat dateFormat = DateFormat.d();

    if (isLoading) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(241, 244, 248, 1),
        appBar: AppBar(
          title: Text('Report'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Center(
            child:
                CircularProgressIndicator()), // Show a loading indicator while data is being loaded
      );
    }

    // Filter data based on the selected view
    List<dynamic> filteredData;
    if (_selectedView == 'Day') {
      filteredData = jsonData['days']
          .where((item) => _selectedDayIndices.contains(
              currentMonthDates.indexOf(DateTime.parse(item['date']))))
          .toList();
    } else if (_selectedView == 'Week') {
      filteredData = jsonData['weeks'];
    } else {
      filteredData = jsonData['months'];
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 244, 248, 1),
      appBar: AppBar(
        title: Text('Report'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Dates only when 'Day' is selected
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 20.h),
              child: Text(
                "History",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppin',
                    color: Colors.black),
              ),
            ),
            if (_selectedView == 'Day')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  height: 80.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentMonthDates.length,
                    itemBuilder: (context, index) {
                      DateTime date = currentMonthDates[index];
                      bool isSelected = _selectedDayIndices.contains(index);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedDayIndices.remove(index);
                            } else {
                              _selectedDayIndices.add(index);
                            }
                          });
                        },
                        child: Container(
                          width: 45.w,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayFormat.format(
                                    date)[0], // Display first letter of the day
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                              CheckBoxWidget(
                                value: isSelected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedDayIndices.add(index);
                                    } else {
                                      _selectedDayIndices.remove(index);
                                    }
                                  });
                                },
                              ),
                              Text(
                                dateFormat.format(date), // Display date
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            // Fragment Component for Day, Week, and Year
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ReportFragmentComponent(
                firstOption: 'Day',
                secondOption: 'Week',
                thirdOption: 'Month',
                onSelected: (selected) {
                  setState(() {
                    _selectedView = selected;
                    _selectedDayIndices.clear(); // Reset selected indices
                  });
                },
              ),
            ),
            SizedBox(height: 20.h),
            // Display chart based on selected view and filtered data
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 304.h,
                width: 320.w,
                child: Expanded(
                  child: CaloriesBurnedChart(
                      data: filteredData, view: _selectedView),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Display chart based on selected view and filtered data
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 304.h,
                width: 320.w,
                child: Expanded(
                  child: WeightTrackingChart(
                      data: filteredData, view: _selectedView),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Display chart based on selected view and filtered data
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 304.h,
                width: 320.w,
                child: Expanded(
                  child:
                      StepsReportChart(data: filteredData, view: _selectedView),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 276.h,
                width: 320.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 84.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r)),
                        color: Color.fromRGBO(245, 250, 255, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18.0.w.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "All-Time Stats",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppin'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Member since",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(146, 153, 163, 1),
                                      fontFamily: 'Poppin'),
                                ),
                                Text(
                                  " 20 May 2024",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(146, 153, 163, 1),
                                      fontFamily: 'Poppin'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                'Foods Logged',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                              Spacer(),
                              Text(
                                '5',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                'Meals Logged',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                              Spacer(),
                              Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                'Exercises Logged',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                              Spacer(),
                              Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Text(
                                'Steps Logged',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                              Spacer(),
                              Text(
                                '0',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'OpenSans'),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
