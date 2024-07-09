import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/weightStepIndicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<dynamic> entries = [];
  Map<String, dynamic> weightData = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    try {
      final String response =
          await rootBundle.loadString('lib/json files/progress.json');
      final String weightChartJson =
          await rootBundle.loadString('lib/json files/weightChart.json');
      final data = json.decode(response);
      final weightDataJson = json.decode(weightChartJson);

      setState(() {
        entries = data['entries'];
        weightData = weightDataJson;
      });
    } catch (e) {
      print('Error loading JSON files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 244, 247, 1),
      appBar: AppBar(
        title: Text(
          'Progress',
          style: TextStyle(
              fontSize: 19.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            GestureDetector(
              onTap: () {
                print('Weight');
              },
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(223, 234, 237, 1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              'images/weightIcon.png',
                              height: 18.h,
                              width: 20.w,
                            ),
                            SizedBox(width: 55.w),
                            Text(
                              'Weight',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(21, 109, 149, 1),
                                  fontFamily: 'Inter'),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: Color.fromRGBO(211, 234, 240, 1),
                        thickness: 1.w,
                        width: 20.w,
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              print('3 Months');
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                ),
                                Image.asset(
                                  'images/date.png',
                                  height: 18.h,
                                  width: 20.w,
                                ),
                                SizedBox(width: 30.w),
                                Text(
                                  '3 Months',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(21, 109, 149, 1),
                                      fontFamily: 'Inter'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0.w.h),
              child: Container(
                height: 250.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: Center(
                    child: CustomGraph(
                      heading: weightData['heading'] ?? '',
                      subHeading: weightData['subHeading'] ?? '',
                      value: weightData['value'] ?? 0,
                      date: (weightData['dates'] != null &&
                              weightData['dates'].isNotEmpty)
                          ? (weightData['dates'].last as String)
                          : '',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Explore',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter')),
                    ],
                  ),
                  Divider(
                    color: Color.fromRGBO(211, 234, 240, 1),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    entries[index]['date'],
                                    style: TextStyle(
                                        fontSize: 16.sp, fontFamily: 'Inter'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    entries[index]['weight'],
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromRGBO(160, 160, 160, 1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            entries[index]['image'],
                            width: 51.w,
                            height: 51.w,
                          ),
                        ],
                      ),
                      Divider(
                        color: Color.fromRGBO(211, 234, 240, 1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
