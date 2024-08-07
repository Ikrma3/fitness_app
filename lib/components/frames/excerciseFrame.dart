import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

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
    double imaegsize = title == "Rest" ? 40.0 : 64.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(10.w.h),
        decoration: BoxDecoration(
          gradient: AppColors.getFrameGradient(context),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                  height: 64.h,
                  child: Image.asset(image,
                      width: imaegsize.w,
                      height: imaegsize.h,
                      fit: BoxFit.contain)),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 176.w,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppin'),
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'OpenSans',
                    color: AppColors.getSubtitleColor(context),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 20.w.h,
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
