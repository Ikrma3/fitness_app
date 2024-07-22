import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseFrame extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final VoidCallback onTap;

  ExerciseFrame({
    required this.image,
    required this.title,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(10.w.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Image.asset(image, width: 64.w, height: 64.h, fit: BoxFit.cover),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppin'),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'OpenSans',
                    color: Color.fromRGBO(64, 75, 82, 1),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 22.w.h,
                color: Color.fromRGBO(202, 208, 216, 1),
              ),
              onPressed: () {
                // Handle info button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
