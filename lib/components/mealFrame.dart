import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/customAddIcon.dart';

class MealFrame extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  MealFrame({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Stack(
          children: [
            // Background SVG Image
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 60.h, // Set a fixed height
              fit: BoxFit.cover,
            ),

            // Gradient Overlay
            Container(
              height: 60.h, // Set a fixed height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(235, 235, 235, 1),
                    Color.fromRGBO(128, 128, 128, 0),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            //Content
            Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                ),
                CustomIconButton(
                  onPressed: () {
                    // Add your onPressed code here
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
