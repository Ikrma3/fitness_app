import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitness/components/caloriesLeftIndicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/dairyCards.dart';
import 'package:myfitness/components/smallSubmitButton.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/breakFastScreen.dart';
import 'package:myfitness/screens/dinnerScreen.dart';
import 'package:myfitness/screens/lunchScreen.dart';
import 'package:myfitness/screens/snackScreen.dart';

class DairyScreen extends StatefulWidget {
  @override
  _DairyScreenState createState() => _DairyScreenState();
}

class _DairyScreenState extends State<DairyScreen> {
  Future<Map<String, dynamic>> loadCaloriesLeftData() async {
    try {
      String jsonString =
          await rootBundle.loadString('lib/json files/caloriesLeft.json');
      final jsonResponse = json.decode(jsonString);
      return jsonResponse;
    } catch (e) {
      print("Error loading calories left JSON: $e");
      throw Exception("Error loading calories left JSON");
    }
  }

  Future<List<dynamic>> loadData(String fileName) async {
    try {
      String jsonString =
          await rootBundle.loadString('lib/json files/$fileName.json');
      final jsonResponse = json.decode(jsonString);
      return jsonResponse;
    } catch (e) {
      print("Error loading $fileName JSON: $e");
      throw Exception("Error loading $fileName JSON");
    }
  }

  void handleAddPressed(String heading) {
    print("Add pressed for: $heading");
    if ('${heading}' == 'Breakfast') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BreakFastScreen()),
      );
    } else if ('${heading}' == 'Lunch') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LunchScreen()),
      );
    } else if ('${heading}' == 'Snack') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SnackScreen()),
      );
    } else if ('${heading}' == 'Dinner') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DinnerScreen()),
      );
    }
  }

  void handleDetailPressed(String heading, String detail) {
    print("Detail pressed for: $heading - $detail");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Text(
          'Dairy ',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    'Today',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: 105.h,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: loadCaloriesLeftData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          var data = snapshot.data!;
                          var heading = data['heading'];
                          var percent = data['percent'];
                          var goal = data['goal'];
                          var food = data['food'];
                          var exercise = data['exercise'];

                          return CaloriesLeftIndicator(
                            heading: heading,
                            percent: percent,
                            goal: goal,
                            food: food,
                            exercise: exercise,
                          );
                        } else {
                          return Center(child: Text('No data found'));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairyBreakfast'),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairyLunch'),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairyDinner'),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairySnacks'),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairyExercise'),
                  SizedBox(height: 20.h),
                  _buildDairyData('dairyWater'),
                  SizedBox(height: 150.h),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: SmallCustomButton(
              onTap: () {},
              text: "Nutrition",
              image: Image.asset('images/nutritionButton.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDairyData(String fileName) {
    return FutureBuilder<List<dynamic>>(
      future: loadData(fileName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var dairyData = snapshot.data!;
          return Column(
            children: dairyData.map((item) {
              return DairyCard(
                heading: item['heading'],
                subheading: item['subheading'],
                imagePath: item['imagePath'],
                details: List<String>.from(item['details']),
                quanDetails: List<String>.from(item['quanDetails']),
                calDetails: List<String>.from(item['calDetails']),
                onAddPressed: handleAddPressed,
                onDetailPressed: handleDetailPressed,
              );
            }).toList(),
          );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}
