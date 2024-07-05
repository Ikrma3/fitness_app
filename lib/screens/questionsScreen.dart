import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/frame.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/stepIndicator.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/trainingPlanIndicator.dart';
import 'dob.dart'; // Importing the DOB screen

class QuestionScreen extends StatefulWidget {
  final int initialQuestionId;

  QuestionScreen({required this.initialQuestionId});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<dynamic> _questions = [];
  late List<String> _selectedAnswers = [];
  PageController _pageController = PageController();
  int _currentQuestionIndex = 0;
  bool _isFirstQuestionCompleted = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    final String response =
        await rootBundle.rootBundle.loadString('lib/json files/questions.json');
    final data = json.decode(response);
    setState(() {
      _questions = data['questions'];
      _currentQuestionIndex = widget.initialQuestionId - 1;
      _pageController = PageController(initialPage: _currentQuestionIndex);
    });
  }

  void navigateToNextQuestion() {
    final currentQuestion = _questions[_currentQuestionIndex];
    if (_pageController.hasClients) {
      if (currentQuestion['title'].contains('Pick 3') &&
          _selectedAnswers.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please pick 3 answers.')),
        );
        return;
      }
      print(
          'Selected answers for question ${_currentQuestionIndex + 1}: $_selectedAnswers');
      sendAnswersToBackend(_selectedAnswers);

      if (_currentQuestionIndex + 1 == 1) {
        print("_currentQuestionIndex");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DOBScreen()),
        ).then((_) {
          setState(() {
            _currentQuestionIndex++;
            _isFirstQuestionCompleted = true;
            _pageController.jumpToPage(_currentQuestionIndex);
            _selectedAnswers.clear();
          });
        });
      } else if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        _selectedAnswers.clear();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrainingPlanScreen()),
        );
      }
    }
  }

  void navigateToPreviousQuestion() {
    if (_pageController.hasClients && _currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _selectedAnswers.clear();
    }
  }

  void sendAnswersToBackend(List<String> answers) {
    print('Sending answers to backend: $answers');
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(30, 34, 53, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    if (_questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: navigateToPreviousQuestion,
          ),
        ),
        title: Center(
          child: StepIndicator(
            currentStep: _currentQuestionIndex + 1,
            totalSteps: 11,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: SkipButton(onPressed: navigateToNextQuestion),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _questions.length,
                physics:
                    _currentQuestionIndex == 0 && !_isFirstQuestionCompleted
                        ? NeverScrollableScrollPhysics()
                        : AlwaysScrollableScrollPhysics(),
                onPageChanged: (index) async {
                  if (index > _currentQuestionIndex &&
                      _currentQuestionIndex + 1 == 1) {
                    print("_currentQuestionIndex");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DOBScreen()),
                    ).then((_) {
                      setState(() {
                        _currentQuestionIndex++;
                        _isFirstQuestionCompleted = true;
                        _pageController.jumpToPage(_currentQuestionIndex);
                        _selectedAnswers.clear();
                      });
                    });
                  } else {
                    setState(() {
                      _currentQuestionIndex = index;
                      _selectedAnswers.clear();
                    });
                  }
                },
                itemBuilder: (context, index) {
                  final currentQuestion = _questions[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              currentQuestion['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: pColor,
                                  fontSize: 27.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                          SizedBox(height: 30.h),
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
                                  many: currentQuestion['title']
                                              .contains('gender') ||
                                          currentQuestion['title']
                                              .contains('Training Level')
                                      ? false
                                      : true,
                                  isSelected:
                                      _selectedAnswers.contains(answer['text']),
                                  onChanged: (isChecked) {
                                    setState(() {
                                      if (currentQuestion['title']
                                              .contains('gender') ||
                                          currentQuestion['title']
                                              .contains('Training Level')) {
                                        if (isChecked) {
                                          _selectedAnswers.clear();
                                          _selectedAnswers.add(answer['text']);
                                        } else {
                                          _selectedAnswers
                                              .remove(answer['text']);
                                        }
                                      } else {
                                        if (isChecked) {
                                          _selectedAnswers.add(answer['text']);
                                        } else {
                                          _selectedAnswers
                                              .remove(answer['text']);
                                        }
                                      }
                                    });
                                  },
                                  currentSelections: _selectedAnswers.length,
                                ),
                                SizedBox(height: 15.h),
                              ],
                            );
                          }).toList(),
                          SizedBox(height: 35.h),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
                child: CustomButton(
                  onTap: navigateToNextQuestion,
                  text: "Continue",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
