import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/frame.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/cusine.dart';
import 'package:myfitness/screens/trainingLevel.dart';
import 'package:myfitness/screens/trainingPlanIndicator.dart';
import 'package:myfitness/screens/dob.dart'; // Importing the DOB screen

class ActivityInterest extends StatefulWidget {
  final List<String> userData; // Initial list of selected answers

  ActivityInterest({Key? key, required this.userData}) : super(key: key);

  @override
  _ActivityInterestState createState() => _ActivityInterestState();
}

class _ActivityInterestState extends State<ActivityInterest> {
  List<String> _selectedAnswers = [];
  int _currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'title': 'Choose activities that interest',
      'answers': [
        {'text': 'Cardio', 'image': 'images/cardio.png'},
        {'text': 'Power training', 'image': 'images/power.png'},
        {'text': 'Stretch', 'image': 'images/stretch.png'},
        {'text': 'Dancing', 'image': 'images/dancing.png'},
        {'text': 'Yoga', 'image': 'images/yoga.png'},
      ],
      'many': true,
    },
    // Add more questions here
  ];

  @override
  void initState() {
    super.initState();
    // Initialize _selectedAnswers with userData if it's not empty
    if (widget.userData.isNotEmpty) {
      // Find 'diagnosed' entry in userData and extract selected conditions
      for (String item in widget.userData) {
        if (item.startsWith('activity_interest:')) {
          // Extract conditions from diagnosed entry
          _selectedAnswers = item.substring(11, item.length - 1).split(', ');
        }
      }
    }
  }

  void navigateToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Create a copy of userData to modify
        List<String> updatedUserData = List.of(widget.userData);

        // Format the selected medical conditions
        String formattedDiagnosed =
            'activity_interest: [${_selectedAnswers.join(', ')}]';

        // Remove any existing 'diagnosed' entry from userData
        updatedUserData
            .removeWhere((item) => item.startsWith('activity_interest:'));

        // Add formatted diagnosed entry to userData
        updatedUserData.add(formattedDiagnosed);

        // Navigate to DOB screen with updated user data
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrainingPlanScreen()),
        );
        print(updatedUserData);
      }
    });
  }

  void navigateToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(30, 34, 53, 1)
        : Color.fromRGBO(245, 250, 255, 1);

    if (questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bColor,
        title: Center(
          child: Row(
            children: [
              SizedBox(
                width: 60.w,
              ),
              Text(
                "Step 9 0f 11",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(21, 109, 149, 1)),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(height: 50.h), // Add some space at the top
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    currentQuestion['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: pColor,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppin'),
                  ),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...(currentQuestion['answers'] as List)
                            .map<Widget>((answer) {
                          return Column(
                            children: [
                              Frame(
                                image: answer.containsKey('image')
                                    ? answer['image']
                                    : null,
                                name: 'Answer',
                                text: answer['text'] ?? '',
                                subtitle: answer['subtitle'] ?? null,
                                many: true,
                                isSelected:
                                    _selectedAnswers.contains(answer['text']),
                                onChanged: (isChecked) {
                                  setState(() {
                                    if (isChecked) {
                                      _selectedAnswers.add(answer['text']);
                                    } else {
                                      _selectedAnswers.remove(answer['text']);
                                    }
                                  });
                                },
                                currentSelections: _selectedAnswers.length,
                              ),
                              SizedBox(height: 15.h),
                            ],
                          );
                        }).toList(),
                        SizedBox(height: 80.h), // Add some space at the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(
                onTap: () {
                  navigateToNextQuestion();
                },
                text: "Continue",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
