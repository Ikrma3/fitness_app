import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? errorText;

  CustomTextField({
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(217, 237, 245, 1);
    Color tColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(64, 75, 82, 1);
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 12.h),
        labelText: labelText,
        errorText: errorText,
        labelStyle: TextStyle(
          color: tColor,
          fontFamily: 'Inter', // Set label text color here
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0.r),
          borderSide: BorderSide(
            color: Color.fromRGBO(20, 108, 148, 1),
            // Change this to the desired color
          ),
        ),
        filled: true,
        fillColor: errorText == null ? pColor : Colors.red.withOpacity(0.1),
      ),
      obscureText: obscureText,
    );
  }
}
