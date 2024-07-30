import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/customSleepIndicator.dart';
import 'package:myfitness/screens/sleepOverviewScreen.dart'; // Import SleepOverviewScreen

class SleepScreenFood extends StatefulWidget {
  @override
  _SleepScreenFoodState createState() => _SleepScreenFoodState();
}

class _SleepScreenFoodState extends State<SleepScreenFood> {
  Map<String, dynamic> _data = {};
  int _currentIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String response =
        await rootBundle.loadString('lib/json files/sleep.json');
    final data = await json.decode(response);
    setState(() {
      _data = data;
      _updateIndexByDate(_selectedDate);
    });
  }

  void _updateIndexByDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    for (int i = 0; i < _data['dates'].length; i++) {
      if (_data['dates'][i]['date'] == formattedDate) {
        setState(() {
          _currentIndex = i;
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
      _currentIndex += direction;
      if (_currentIndex < 0) {
        _currentIndex = 0;
      } else if (_currentIndex >= _data['dates'].length) {
        _currentIndex = _data['dates'].length - 1;
      }
      _selectedDate = DateTime.parse(_data['dates'][_currentIndex]['date']);
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
    if (_data.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final dateData = _data['dates'][_currentIndex];
    final totalSleep = dateData['total_sleep'];
    final segments = [
      Segment(
          color: Color.fromRGBO(211, 234, 240, 1),
          percentage: dateData['rem'].toDouble() / 10),
      Segment(
          color: Color.fromRGBO(250, 155, 49, 1),
          percentage: dateData['awake'].toDouble() / 10),
      Segment(
          color: Color.fromRGBO(236, 55, 98, 1),
          percentage: dateData['deep'].toDouble() / 10),
      Segment(
          color: Color.fromRGBO(20, 108, 148, 1),
          percentage: dateData['light'].toDouble() / 10),
    ];

    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        surfaceTintColor: AppColors.getAppbarColor(context),
        title: Text('Sleep'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Color.fromRGBO(204, 204, 204, 1)),
                    onPressed: () => _navigateDate(-1),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Column(
                      children: [
                        Text('Day View',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color.fromRGBO(102, 102, 102, 1))),
                        Text(
                            _isToday(dateData['date'])
                                ? 'Today'
                                : dateData['date'],
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: Color.fromRGBO(204, 204, 204, 1)),
                    onPressed: () => _navigateDate(1),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10.h),
                        SleepCircularSegmentProgressIndicator(
                          segments: segments,
                          radius: 100.r,
                          lineWidth: 15.0.w,
                          animation: true,
                          centerWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/sleep.png',
                                  height: 46.h, width: 46.w),
                              Text(totalSleep,
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Text("Total Sleep",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 14.w.h,
                                      color: Color.fromRGBO(202, 208, 216, 1),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20),
                                          ),
                                        ),
                                        builder: (context) =>
                                            DraggableScrollableSheet(
                                          initialChildSize: 0.82,
                                          maxChildSize: 0.82,
                                          minChildSize: 0.5,
                                          expand: false,
                                          builder: (context, scrollController) {
                                            return SingleChildScrollView(
                                              controller: scrollController,
                                              child: SleepOverviewScreen(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        _buildMealItem('Awake', dateData['awake']),
                        _buildMealItem('REM', dateData['rem']),
                        _buildMealItem('LIGHT', dateData['light']),
                        _buildMealItem('DEEP', dateData['deep']),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 135.h,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.getGradient(context),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getShadowColor(
                        context), // Shadow color with opacity
                    spreadRadius: 0, // Spread radius
                    blurRadius: 40, // Blur radius
                    offset: Offset(0, 15), // Offset in the x and y direction
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Food Logged",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dateData['Food']?.length ?? 0,
                    separatorBuilder: (context, index) => Divider(
                      height: 1.h,
                      color: Color.fromRGBO(211, 234, 240, 1),
                    ),
                    itemBuilder: (context, index) {
                      final food = dateData['Food'][index];
                      return _buildFoodItem(food['title'], food['subtitile']);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 122.w,
                        height: 36.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Food',
                            style: TextStyle(
                                color: Color.fromRGBO(
                                    21, 109, 149, 1), // Text color
                                fontSize: 16.sp,
                                fontFamily: 'Inter' // Text size
                                ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromRGBO(21, 109, 149, 1),
                            backgroundColor: AppColors.getButtonColor(
                                context), // Text color on the button
                            side: BorderSide(
                                color: Color.fromRGBO(21, 109, 149, 1),
                                width: 1), // Border color and width
                            // Button padding
                            textStyle: TextStyle(
                              fontSize: 16.sp, // Text size
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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

  Color _getColors(String mealName) {
    switch (mealName) {
      case 'Awake':
        return Color.fromRGBO(250, 155, 49, 1);
      case 'REM':
        return Color.fromRGBO(211, 234, 240, 1);
      case 'LIGHT':
        return Color.fromRGBO(20, 108, 148, 1);
      case 'DEEP':
        return Color.fromRGBO(236, 55, 98, 1);
      default:
        return Colors.black;
    }
  }

  Widget _buildMealItem(String name, int value) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 26.h,
          decoration: BoxDecoration(
              color: _getColors(name),
              borderRadius: BorderRadius.circular(12.r)),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500)),
            Text(value.toString(),
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(102, 102, 102, 1))),
          ],
        ),
        SizedBox(
          height: 45.h,
        ),
      ],
    );
  }

  Widget _buildFoodItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600)),
        Text(subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.getSubtitleColor(context),
            )),
        SizedBox(height: 10.h),
      ],
    );
  }
}
