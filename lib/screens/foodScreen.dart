import 'package:flutter/material.dart';
import 'package:myfitness/components/smallSubmitButton.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myfitness/components/foodIndicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Update the path to your FoodCalIndicator file

class FoodScreen extends StatelessWidget {
  final String title;
  final String image;
  final double protein;
  final double carbs;
  final double fats;
  final String meal;
  final String time;
  final Map<String, double> dailyGoals;

  FoodScreen({
    required this.title,
    required this.image,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.meal,
    required this.time,
    required this.dailyGoals,
  });

  @override
  Widget build(BuildContext context) {
    final double totalCalories = (protein * 4) + (carbs * 4) + (fats * 9);
    final double totalDailyCalories = (dailyGoals['totalProtein']! * 4) +
        (dailyGoals['totalCarb']! * 4) +
        (dailyGoals['totalFat']! * 9);

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      body: Column(
        children: [
          Stack(
            children: [
              // Image Container
              Container(
                height: 207.h,
                width: double.infinity,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              // Transparent AppBar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  elevation: 0,
                  backgroundColor:
                      Color.fromARGB(60, 0, 0, 0), // Transparent AppBar
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 10, // Adjust this value for spacing
                left: 20,
                right: 0,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0.w.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FoodCalIndicator(
                              protein: protein,
                              carbs: carbs,
                              fats: fats,
                            ),
                            SizedBox(width: 10.0.w),
                            _buildNutrientIndicator(protein, 'Protein',
                                Color.fromRGBO(21, 109, 149, 1)),
                            SizedBox(width: 10.0),
                            _buildNutrientIndicator(
                                carbs, 'Carbs', Color.fromRGBO(244, 66, 55, 1)),
                            SizedBox(width: 10.0),
                            _buildNutrientIndicator(
                                fats, 'Fats', Color.fromRGBO(250, 155, 49, 1)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      Divider(),
                      SizedBox(height: 16.0.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Meal:',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Inter'),
                              ),
                              Spacer(),
                              Text(
                                '$meal',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(211, 234, 240, 1),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                'Number of Servings:',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Inter'),
                              ),
                              Spacer(),
                              Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(211, 234, 240, 1),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                'Size',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Inter'),
                              ),
                              Spacer(),
                              Text(
                                '20g',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(211, 234, 240, 1),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                'Time:',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Inter'),
                              ),
                              Spacer(),
                              Text(
                                '$time',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color.fromRGBO(211, 234, 240, 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0.h),
                      SizedBox(height: 16.0.h),
                      Text(
                        'Percentage of Your Daily Goals',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Inter'),
                      ),
                      SizedBox(height: 18.0.h),
                      _buildDailyGoalIndicators(),
                      SizedBox(height: 16.0.h),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: SmallCustomButton(
                      text: 'Add',
                      image: Image.asset('images/plus.png'),
                      onTap: () {}))
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientIndicator(double value, String label, Color color) {
    return Column(
      children: [
        Text(
          '${(value / (protein + carbs + fats) * 100).toStringAsFixed(0)}%',
          style: TextStyle(
              fontSize: 12.sp,
              color: color,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter'),
        ),
        Text('${value.toStringAsFixed(1)}g',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter')),
        Text(label,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter')),
      ],
    );
  }

  Widget _buildDailyGoalIndicator(
      String label, double value, double total, LinearGradient gradient) {
    // Ensure the percentage is between 0.0 and 1.0
    double percent = (value / total).clamp(0.0, 1.0);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0.w),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter'),
                ),
              ],
            ),
            SizedBox(height: 4.0.h),
            LinearPercentIndicator(
              lineHeight: 4.h,
              percent: percent,
              backgroundColor: Colors.grey[300],
              linearGradient: gradient,
            ),
            SizedBox(height: 6.0.h),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '${(percent * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
                Spacer(),
                Text(
                  '${total.toInt()}',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyGoalIndicators() {
    final double totalCalories = 2000;
    // (dailyGoals['protein']! * 4) +
    //     (dailyGoals['carbs']! * 4) +
    //     (dailyGoals['fats']! * 9);
    final double totalDailyCalories = (dailyGoals['totalProtein']! * 4) +
        (dailyGoals['totalCarb']! * 4) +
        (dailyGoals['totalFat']! * 9);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDailyGoalIndicator(
            'Calories',
            totalCalories,
            totalDailyCalories,
            LinearGradient(colors: [
              Color.fromRGBO(20, 108, 148, 1),
              Color.fromRGBO(255, 2, 2, 1)
            ])),
        _buildDailyGoalIndicator(
            'Carbs',
            dailyGoals['carbs']!,
            dailyGoals['totalCarb']!,
            LinearGradient(colors: [
              Color.fromRGBO(244, 66, 55, 1),
              Color.fromRGBO(244, 66, 55, 1)
            ])),
        _buildDailyGoalIndicator(
            'Fats',
            dailyGoals['fats']!,
            dailyGoals['totalFat']!,
            LinearGradient(colors: [
              Color.fromRGBO(250, 155, 49, 1),
              Color.fromRGBO(250, 155, 49, 1)
            ])),
        _buildDailyGoalIndicator(
            'Protein',
            dailyGoals['protein']!,
            dailyGoals['totalProtein']!,
            LinearGradient(colors: [
              Color.fromRGBO(21, 109, 149, 1),
              Color.fromRGBO(21, 109, 149, 1)
            ])),
      ],
    );
  }
}
