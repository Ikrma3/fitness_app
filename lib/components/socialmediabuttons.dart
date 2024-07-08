import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 70.w),
      child: Row(
        children: [
          SizedBox(
            width: 45.w,
            height: 45.h,
            child: Image.asset(
              'images/logos_apple.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 20.w),
          SizedBox(
            width: 45.w,
            height: 45.h,
            child: Image.asset(
              'images/logos_fb.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 20.w),
          SizedBox(
            width: 45.w,
            height: 45.h,
            child: Image.asset(
              'images/logos_google.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
