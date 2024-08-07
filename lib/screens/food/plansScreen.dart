import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/buttons/customPlansButton.dart';
import 'package:myfitness/components/cards/plansCard.dart';
import 'package:myfitness/components/tabs/bottomBar.dart';
import 'package:myfitness/components/colours.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/food/myPlans.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/settings/settings.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  String selectedFilter = ""; // No filter selected by default
  Map<String, dynamic>? jsonData;
  List<String> filters = [];
  int _currentIndex = 3;
  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        _currentIndex = 3;
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DairyScreen()),
        );
        _currentIndex = 3;
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanScreen()),
        );
        _currentIndex = 3;
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        _currentIndex = 3;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  Future<void> loadJsonData() async {
    try {
      String data = await rootBundle.loadString('lib/json files/plans.json');
      setState(() {
        jsonData = json.decode(data);
        filters = List<String>.from(jsonData!['filters']);
      });
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              "Plans",
              style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter'),
            )),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.getAppbarColor(context),
          surfaceTintColor: AppColors.getAppbarColor(context),
          title: Text(
            "Plans",
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0.w.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PlanButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPlans(),
                        ),
                      );
                      // Handle button press
                    },
                    text: 'My Plan',
                    image: Image.asset('assets/icons/icon_plan.png'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    jsonData!['heading'],
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                jsonData!['subHeading'],
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
              ),
              SizedBox(height: 12.h),
              Text(
                "Filter by:",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter'),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 27.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    String filter = filters[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Reset selection if the filter is already selected
                          if (selectedFilter == filter) {
                            selectedFilter = "";
                          } else {
                            selectedFilter = filter;
                          }
                        });
                      },
                      child: Container(
                        height: 8.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 2.h),
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: selectedFilter == filter
                              ? Color.fromRGBO(21, 109, 149, 1)
                              : AppColors.getBackgroundColor(context),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(211, 234, 240,
                                1), // Specify your border color here
                            width: 1.w, // Specify the border width
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Divider(
                color: Color.fromRGBO(211, 234, 240, 1),
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: selectedFilter.isEmpty
                    ? ListView.builder(
                        itemCount: jsonData!['data']['General'].length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item =
                              jsonData!['data']['General'][index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: PlansCardComponent(
                              pngImage: item['svgImage'],
                              heading: item['heading'],
                              subHeading: item['subHeading'],
                              overview: item['overview'],
                              schedule: item['schedule'],
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: jsonData!['data'][selectedFilter].length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item =
                              jsonData!['data'][selectedFilter][index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: PlansCardComponent(
                              pngImage: item['svgImage'],
                              heading: item['heading'],
                              subHeading: item['subHeading'],
                              overview: item['overview'],
                              schedule: item['schedule'],
                            ),
                          );
                        },
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