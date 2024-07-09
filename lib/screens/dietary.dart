import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/frame.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/cusine.dart';
import 'package:myfitness/screens/diagnosed.dart';
import 'package:myfitness/screens/trainingPlanIndicator.dart';
import 'package:myfitness/screens/dob.dart'; // Importing the DOB screen

class Dietary extends StatefulWidget {
  final List<String> userData; // Initial list of selected answers

  Dietary({Key? key, required this.userData}) : super(key: key);

  @override
  _DietaryState createState() => _DietaryState();
}

class _DietaryState extends State<Dietary> {
  List<String> _selectedAnswers = [];
  int _currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'title': 'Dietary habits',
      'answers': [
        {'text': 'Non Vegetarian', 'image': 'images/nVeg.png'},
        {'text': 'vegetarian', 'image': 'images/veg.png'},
        {'text': 'Pescetarian', 'image': 'images/pes.png'},
        {'text': 'I eat all', 'image': 'images/eAll.png'},
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
        if (item.startsWith('dietary:')) {
          // Extract conditions from diagnosed entry
          _selectedAnswers = item.substring(4, item.length - 1).split(', ');
        }
      }
    }
  }

  void navigateToNextQuestion() {
    setState(() {
      // Create a copy of userData to modify
      List<String> updatedUserData = List.of(widget.userData);

      // Format the selected medical conditions
      String formattedDiagnosed = 'dietary: [${_selectedAnswers.join(', ')}]';

      // Remove any existing 'diagnosed' entry from userData
      updatedUserData.removeWhere((item) => item.startsWith('dietary:'));

      // Add formatted diagnosed entry to userData
      updatedUserData.add(formattedDiagnosed);

      // Navigate to DOB screen with updated user data
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cusine(userData: updatedUserData)),
      );
      print(updatedUserData);
    });
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
          child: Text(
            "Step 6 0f 11",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: Color.fromRGBO(21, 109, 149, 1)),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: SkipButton(onPressed: navigateToNextQuestion),
          ),
        ],
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
