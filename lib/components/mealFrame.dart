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
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [Color.fromRGBO(45, 52, 80, 1), Color.fromRGBO(128, 128, 128, 0)]
        : [
            Color.fromRGBO(235, 235, 235, 1),
            Color.fromRGBO(128, 128, 128, 0),
          ];
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
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
              height: 56.h, // Set a fixed height
              fit: BoxFit.fill,
            ),

            // Gradient Overlay
            Container(
              height: 56.h,
              width: 320.w, // Set a fixed height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.8],
                  colors: pColor,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: tColor,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: tColor,
                            fontWeight: FontWeight.w400,
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
