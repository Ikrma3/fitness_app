import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  SkipButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(64, 75, 82, 1);
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Skip',
        style: TextStyle(color: pColor, fontSize: 15.sp, fontFamily: 'Inter'),
      ),
    );
  }
}
