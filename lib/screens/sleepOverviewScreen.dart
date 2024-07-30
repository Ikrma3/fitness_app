import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

class SleepOverviewScreen extends StatefulWidget {
  @override
  _SleepOverviewScreenState createState() => _SleepOverviewScreenState();
}

class _SleepOverviewScreenState extends State<SleepOverviewScreen> {
  Map<String, dynamic>? sleepData;

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  Future<void> _loadSleepData() async {
    final jsonString =
        await rootBundle.loadString('lib/json files/sleepOverview.json');
    final data = jsonDecode(jsonString);
    setState(() {
      sleepData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return sleepData == null
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.getAppbarColor(context),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 85.w, // Increased width
                        ),
                        Text(
                          "Sleep Overview",
                          style: TextStyle(
                              fontSize: 16.sp, // Increased font size
                              fontWeight:
                                  FontWeight.w600, // Increased font weight
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h, // Increased height
                    ),
                    Text(
                      sleepData!['title'],
                      style: TextStyle(
                          fontSize: 24.sp, // Increased font size
                          fontWeight: FontWeight.w600, // Increased font weight
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 12.h), // Increased height
                    Text(
                      sleepData!['description'],
                      style: TextStyle(
                          fontSize: 14.sp, // Increased font size
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 24.h), // Increased height
                    Text(
                      "About Sleep stages",
                      style: TextStyle(
                          fontSize: 16.sp, // Increased font size
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 12.h), // Increased height
                    ...sleepData!['stages'].map<Widget>((stage) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 16.h,
                                width: 16.h,
                                decoration: BoxDecoration(
                                    color: _getColorFromString(stage['color']),
                                    borderRadius: BorderRadius.circular(32.r)),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                stage['title'],
                                style: TextStyle(
                                    fontSize: 16.sp, // Increased font size
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            stage['description'],
                            style: TextStyle(
                                fontSize: 14.sp, // Increased font size
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 24.h), // Increased height
                    Container(
                      width: 304.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.getSleepContainerColor(context),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w.h),
                        child: Text(sleepData!['note'],
                            style: TextStyle(
                                fontSize: 12.sp, // Increased font size
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Color _getColorFromString(String color) {
    switch (color) {
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
