import 'package:flutter/material.dart';
import 'package:myfitness/screens/dob.dart';
import 'package:myfitness/screens/onBoard.dart';
import 'package:myfitness/screens/questionsScreen.dart';
import 'package:myfitness/screens/signin.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [QuestionScreen(initialQuestionId: 1), DOBScreen()],
      ),
    );
  }
}
