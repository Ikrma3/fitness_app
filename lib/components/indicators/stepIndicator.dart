import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  StepIndicator({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color stepColor = brightness == Brightness.dark
        ? Color.fromARGB(255, 255, 255, 255)
        : Color.fromRGBO(21, 109, 149, 1);
    return Text(
      'Step $currentStep of $totalSteps',
      style: TextStyle(
          fontSize: 16.sp,
          color: stepColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter'),
    );
  }
}
