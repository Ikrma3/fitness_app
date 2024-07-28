import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/equipmentComponent.dart';
import 'package:myfitness/components/excerciseFrame.dart';
import 'package:myfitness/components/smallSubmitButton.dart';
import 'package:myfitness/screens/startTrainingScreen.dart';

class WorkoutDetails extends StatefulWidget {
  @override
  _WorkoutDetailsState createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  Map<String, dynamic>? workoutData;

  @override
  void initState() {
    super.initState();
    loadWorkoutData();
  }

  Future<void> loadWorkoutData() async {
    final String response =
        await rootBundle.loadString('lib/json files/workoutDetails.json');
    final data = await json.decode(response);
    setState(() {
      workoutData = data;
    });
  }

  void startWorkout() {
    List<Map<String, dynamic>> exercises = [];
    workoutData!['exercises'].forEach((sectionTitle, sectionData) {
      sectionData['exercisesList'].forEach((exercise) {
        exercises.add(exercise);
      });
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StartTrainingScreen(
        exercises: exercises,
        totalExercises: exercises.length,
        totalTime: exercises.fold(0, (sum, exercise) {
          final time = exercise['time'];
          if (time != null && time.contains(':')) {
            final timeParts = time.split(':');
            return sum + int.parse(timeParts[0]) * 60 + int.parse(timeParts[1]);
          }
          return sum;
        }),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (workoutData == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Cover Image
          Image.asset(
            workoutData!['coverImage'],
            fit: BoxFit.cover,
            height: 289.h, // Adjust height as needed
            width: double.infinity,
          ),
          // AppBar
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          // Content
          Positioned(
            top: 263.h, // Adjust top position as needed
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 263.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0.r),
                  topRight: Radius.circular(30.0.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0.w.h),
                      child: Text(
                        workoutData!['title'],
                        style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppin'),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w.h),
                      child: Text(
                        workoutData!['description'],
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'OpenSans'),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.all(16.0.w.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: workoutData!['details'].map<Widget>((detail) {
                          return Container(
                            //color: Colors.white,
                            width: 96.w,
                            height: 72.h,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color.fromRGBO(229, 233, 239, 1),
                                  width: 1.w,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(detail['image'],
                                    width: 24.w, height: 24.w),
                                SizedBox(height: 5),
                                Text(
                                  detail['text'],
                                  style: TextStyle(
                                      fontSize: 12.sp, fontFamily: 'Poppin'),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Text(
                        'Equipment',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppin'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Container(
                        height: 122.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: workoutData!['equipment']
                              .map<Widget>((equipment) {
                            return Padding(
                              padding: EdgeInsets.all(8.0.w.h),
                              child: Equipment(
                                imageUrl: equipment['image'],
                                text: equipment['text'],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      color: AppColors.backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.all(10.0.w.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Text("Exercises",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppin')),
                            SizedBox(
                              height: 15.h,
                            ),
                            _buildExerciseSections(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: SmallCustomButton(
              onTap: startWorkout,
              text: "Start Workout",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseSections() {
    List<Widget> sections = [];
    workoutData!['exercises'].forEach((sectionTitle, sectionData) {
      sections.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppin',
                ),
              ),
              Text(
                '${sectionData['exerciseCount']} Exercises • ${sectionData['totalTime']}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'OpenSans',
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
      sections.add(SizedBox(height: 10.h));
      sectionData['exercisesList'].forEach((exercise) {
        sections.add(ExerciseFrame(
          image: exercise['image'],
          title: exercise['title'],
          time: exercise['time'] != null ? exercise['time'] : exercise['count'],
          onTap: () {},
        ));
      });
      sections.add(SizedBox(height: 20.h)); // Add some space after each section
    });
    return Column(children: sections);
  }
}
