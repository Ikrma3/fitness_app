import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/customPlansButton.dart';
import 'package:myfitness/components/plansCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/myPlans.dart';

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
          MaterialPageRoute(builder: (context) => CNMViewScreen()),
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
            title: Text(
          "Plans",
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        )),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        backgroundColor: Color.fromRGBO(245, 250, 255, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(245, 250, 255, 1),
          title: Text(
            "Plans",
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0.w.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    jsonData!['heading'],
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                  ),
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
                    image: Image.asset('images/planIcon.png'),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                jsonData!['subHeading'],
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
              ),
              SizedBox(height: 16.h),
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
                        height: 10.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 2.h),
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: selectedFilter == filter
                              ? Color.fromRGBO(21, 109, 149, 1)
                              : Color.fromRGBO(245, 250, 255, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(211, 234, 240,
                                1), // Specify your border color here
                            width: 2.w, // Specify the border width
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: selectedFilter == filter
                                  ? Colors.white
                                  : Colors.black,
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
                color: Colors.grey,
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
