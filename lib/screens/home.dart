import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myfitness/components/cards/homeCards.dart';
import 'package:myfitness/components/frames/mealFrame.dart';
import 'package:myfitness/components/indicators/weightStepIndicator.dart';
import 'package:myfitness/components/tabs/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/dailyExcersice.dart';
import 'package:myfitness/components/exploreScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/waterAndSteps.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/food/plansScreen.dart';
import 'package:myfitness/screens/settings/settings.dart';

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
  String selectedOption = 'Today';

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
          MaterialPageRoute(builder: (context) => SettingsScreen()),
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
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    return Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.getAppbarColor(context),
          surfaceTintColor: AppColors.getAppbarColor(context),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton<String>(
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      selectedOption,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: pColor,
                          fontFamily: 'Inter'),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
                onSelected: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'Today',
                      child: Text('Today'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Option 3',
                      child: Text('Option 3'),
                    ),
                  ];
                },
              ),
              SizedBox(width: 48.w),
              Image.asset(
                'assets/logo/appLogo.png',
                width: 97.w,
                height: 32.h,
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications_none, size: 20.h.w),
              onPressed: () {
                // Handle notification icon tap
              },
            ),
          ],
        ),
        body: cardsData.isEmpty || mealData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 230.h,
                        width: 330.w,
                        child: PageView.builder(
                          itemCount: cardsData.length,
                          onPageChanged: (int index) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: HomeCard(
                                cardData: cardsData[index],
                                isActive: index == currentPage,
                                height: 240.h,
                                width: 320.w,
                              ),
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
                                  ? const Color.fromRGBO(21, 109, 149, 1)
                                  : const Color.fromRGBO(183, 198, 202, 1),
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                gradient:
                                    AppColors.getWeightStepGradient(context),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  gradient:
                                      AppColors.getWeightStepGradient(context),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: CustomGraph(
                                    heading: stepsData['heading'] ?? '',
                                    subHeading: stepsData['subHeading'] ?? '',
                                    value: stepsData['value'] ?? 0,
                                    date: (stepsData['dates'] != null &&
                                            stepsData['dates'].isNotEmpty)
                                        ? (stepsData['dates'].last as String)
                                        : '',
                                  ),
                                ),
                              ),
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
                                  ? const Color.fromRGBO(21, 109, 149, 1)
                                  : const Color.fromRGBO(183, 198, 202, 1),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentGraphPage == 1
                                  ? const Color.fromRGBO(21, 109, 149, 1)
                                  : const Color.fromRGBO(183, 198, 202, 1),
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
