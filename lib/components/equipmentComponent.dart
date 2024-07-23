import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Equipment extends StatelessWidget {
  final String imageUrl;
  final String text;

  Equipment({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 107.w, height: 81.h),
        Text(
          text,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'OpenSans'),
        ),
      ],
    );
  }
}
