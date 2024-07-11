import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomIconButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 26.w, // Adjust the width and height as needed
        height: 26.h,
        decoration: BoxDecoration(
          color: Color.fromRGBO(21, 109, 149, 1), // Set the background color
          shape: BoxShape.circle, // Make it circular
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
