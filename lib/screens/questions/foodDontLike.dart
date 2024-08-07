import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/frames/frame.dart';
import 'package:myfitness/components/buttons/skipButton.dart';

import 'package:myfitness/components/buttons/submitButton.dart';
import 'package:myfitness/screens/questions/waterIntake.dart';

class FoodDontLike extends StatefulWidget {
  final List<String> userData; // Initial list of selected answers

  FoodDontLike({Key? key, required this.userData}) : super(key: key);

  @override
  _FoodDontLikeState createState() => _FoodDontLikeState();
}

class _FoodDontLikeState extends State<FoodDontLike> {
  List<String> _selectedAnswers = [];
  int _currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'title': 'Food you don’t like ',
      'answers': [
        {'text': 'Eggs', 'image': 'assets/images/egg.png'},
        {'text': 'Bread', 'image': 'assets/images/bread.png'},
        {'text': 'Diary', 'image': 'assets/images/diary.png'},
        {'text': 'Peanut', 'image': 'assets/images/peanut.png'},
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
      // Find 'Food_Dont_Like' entry in userData and extract selected conditions
      for (String item in widget.userData) {
        if (item.startsWith('Food_Dont_Like:')) {
          // Extract conditions from Food_Dont_Like entry
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
            'Food_Dont_Like: [${_selectedAnswers.join(', ')}]';

        // Remove any existing 'Food_Dont_Like' entry from userData
        updatedUserData
            .removeWhere((item) => item.startsWith('Food_Dont_Like:'));

        // Add formatted Food_Dont_Like entry to userData
        updatedUserData.add(formattedDiagnosed);

        // Navigate to DOB screen with updated user data
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DailyWaterIntake(userData: updatedUserData)),
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
        ? Color.fromRGBO(34, 35, 50, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    Color sColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(21, 109, 149, 1);

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
            "Step 8 0f 11",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                color: sColor),
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
