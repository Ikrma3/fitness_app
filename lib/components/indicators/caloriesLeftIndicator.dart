import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaloriesLeftIndicator extends StatelessWidget {
  final String heading;
  final int percent;
  final int goal;
  final int food;
  final int exercise;

  CaloriesLeftIndicator({
    required this.heading,
    required this.percent,
    required this.goal,
    required this.food,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.17),
            Color.fromRGBO(90, 200, 250, 0.13)
          ]
        : [Colors.white, Colors.white];
    Color tColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(77, 77, 77, 1);
    Color lineColor = brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Color.fromRGBO(211, 234, 240, 1);
    var remaining = goal - food + exercise;
    var percentage = percent / 100;

    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        padding: EdgeInsets.all(5.w.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: pColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
                const Spacer(),
                Text(
                  '${percent}%',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                height: 17.h,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: lineColor,
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          width: constraints.maxWidth * percentage.toDouble(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: const Color.fromRGBO(21, 109, 149, 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$goal',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                    )),
                SizedBox(width: 15.w),
                Text('-',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(width: 22.w),
                Text(
                  '$food',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 30.w),
                Text('+',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(width: 35.w),
                Text(
                  '$exercise',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(width: 50.w),
                Text(
                  '$remaining',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Goal',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: tColor),
                ),
                SizedBox(width: 46.w),
                Text('Food',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: tColor)),
                SizedBox(width: 60.w),
                Text('Exercise',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: tColor)),
                SizedBox(width: 15.w),
                Text('Remaining',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        color: tColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
