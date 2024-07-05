import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/dailyExcersice.dart';
import 'package:myfitness/components/exploreScreen.dart';
import 'package:myfitness/components/homeCards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/mealFrame.dart';
import 'package:myfitness/components/waterAndSteps.dart';
import 'package:myfitness/components/weightStepIndicator.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cardsData = [];
  List<dynamic> mealData = [];
  Map<String, dynamic> weightData = {};
  Map<String, dynamic> stepsData = {};
  int currentPage = 0;
  int currentGraphPage = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadJsonData();
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
          MaterialPageRoute(builder: (context) => CNMViewScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  Future<void> loadJsonData() async {
    try {
      String homeCardsJson =
          await rootBundle.loadString('lib/json files/homeCards.json');
      String mealsJson =
          await rootBundle.loadString('lib/json files/meals.json');
      String weightChartJson =
          await rootBundle.loadString('lib/json files/weightChart.json');
      String stepsChartJson =
          await rootBundle.loadString('lib/json files/stepChart.json');
      setState(() {
        cardsData = json.decode(homeCardsJson)['cards'];
        mealData = json.decode(mealsJson);
        weightData = json.decode(weightChartJson);
        stepsData = json.decode(stepsChartJson);
      });
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(235, 244, 247, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton<String>(
                child: Row(
                  children: [
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter'),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                onSelected: (value) {
                  // Handle menu item selection
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                    PopupMenuItem<String>(
                      value: 'Option 3',
                      child: Text('Option 3'),
                    ),
                  ];
                },
              ),
              SizedBox(width: 50.w), // Adjust width as needed
              Text(
                'Logo',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter'),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                // Handle notification icon tap
              },
            ),
          ],
        ),
        body: cardsData.isEmpty || mealData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      Container(
                        height: 240.h,
                        width: 320.w,
                        child: PageView.builder(
                          itemCount: cardsData.length,
                          onPageChanged: (int index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return HomeCard(
                              cardData: cardsData[index],
                              isActive: index == currentPage,
                              height: 240.h,
                              width: 320.w,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(cardsData.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? Color.fromRGBO(21, 109, 149, 1)
                                  : Color.fromRGBO(183, 198, 202, 1),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20.h),
                      // Add meal frames
                      Column(
                        children: List.generate(mealData.length, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: MealFrame(
                              imagePath: mealData[index]['image'],
                              title: mealData[index]['title'],
                              subtitle: mealData[index]['subtitle'],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20.h),
                      // Add Water and Step Indicator
                      HealthTrackerComponent(),

                      SizedBox(height: 20.h),
                      DailyExercise(),
                      SizedBox(height: 20.h),
                      // Add Horizontal Graphs
                      Container(
                        height: 240.h,
                        width: 320.w,
                        child: PageView(
                          onPageChanged: (int index) {
                            setState(() {
                              currentGraphPage = index;
                            });
                          },
                          children: [
                            CustomGraph(
                              heading: weightData['heading'] ?? '',
                              subHeading: weightData['subHeading'] ?? '',
                              value: weightData['value'] ?? 0,
                              date: (weightData['dates'] != null &&
                                      weightData['dates'].isNotEmpty)
                                  ? (weightData['dates'].last as String)
                                  : '',
                            ),
                            CustomGraph(
                              heading: stepsData['heading'] ?? '',
                              subHeading: stepsData['subHeading'] ?? '',
                              value: stepsData['value'] ?? 0,
                              date: (stepsData['dates'] != null &&
                                      stepsData['dates'].isNotEmpty)
                                  ? (stepsData['dates'].last as String)
                                  : '',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentGraphPage == 0
                                  ? Color.fromRGBO(21, 109, 149, 1)
                                  : Color.fromRGBO(183, 198, 202, 1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentGraphPage == 1
                                  ? Color.fromRGBO(21, 109, 149, 1)
                                  : Color.fromRGBO(183, 198, 202, 1),
                            ),
                          ),
                        ],
                      ),
                      //Explore container here
                      SizedBox(
                        height: 10.h,
                      ),
                      ExploreScreen(),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }
}
