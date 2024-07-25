import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/trainingButton.dart';
import 'package:myfitness/screens/workoutDetails.dart';

class StartTraining extends StatefulWidget {
  @override
  _StartTrainingState createState() => _StartTrainingState();
}

class _StartTrainingState extends State<StartTraining> {
  Map<String, dynamic> startTrainingData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStartTrainingData();
  }

  Future<void> loadStartTrainingData() async {
    final String response =
        await rootBundle.loadString('lib/json files/startTraining.json');
    final data = await json.decode(response);
    setState(() {
      startTrainingData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      height: 202.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(120, 108, 255, 0.17),
          Color.fromRGBO(90, 200, 250, 0.13)
        ]),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0.w,
            right: -160, // Adjust the left padding as needed
            child: Image.asset(
              startTrainingData['image'],
              height: 201.h,
            ),
          ),
          Positioned(
            left: 0,
            top: 15.h, // Adjust left position considering padding
            child: Container(
              width: 185.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (startTrainingData.containsKey('text') &&
                      startTrainingData['text'] != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        startTrainingData['text'],
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppin',
                            color: Colors.black),
                      ),
                    ),
                  if (startTrainingData.containsKey('description') &&
                      startTrainingData['description'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        startTrainingData['description'],
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'OpenSans',
                            color: Colors.black),
                      ),
                    ),
                  TrainingButton(
                    text: "Start Training",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutDetails()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
