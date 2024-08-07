import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCalIndicator extends StatelessWidget {
  final double protein;
  final double carbs;
  final double fats;

  FoodCalIndicator({
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    double h = 65.h;
    double w = 70.w;
    // Calculate calorie values
    double proteinCal = protein * 4; // 4 calories per gram of protein
    double carbCal = carbs * 4; // 4 calories per gram of carbs
    double fatCal = fats * 9; // 9 calories per gram of fat
    double totalCalories = proteinCal + carbCal + fatCal;

    // Cap total calories at 300 for the purpose of the indicator
    double cappedTotalCalories = totalCalories > 300 ? 300 : totalCalories;

    // Calculate the progress values as a fraction of 300
    double proteinPercentage = proteinCal / 300;
    double carbPercentage = carbCal / 300;
    double fatPercentage = fatCal / 300;

    return Container(
      width: w,
      height: h,
      child: CustomPaint(
        painter: _CaloriePainter(
          proteinPercentage: proteinPercentage,
          carbPercentage: carbPercentage,
          fatPercentage: fatPercentage,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${totalCalories.toInt()}',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    fontFamily: 'Inter'), // Increase font size
              ),
              Text('cal',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      fontFamily: 'Inter') // Adjust font size if needed
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CaloriePainter extends CustomPainter {
  final double proteinPercentage;
  final double carbPercentage;
  final double fatPercentage;

  _CaloriePainter({
    required this.proteinPercentage,
    required this.carbPercentage,
    required this.fatPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 6.0;
    Rect rect = Offset.zero & size;
    double startAngle = -pi / 2;

    Paint backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint proteinPaint = Paint()
      ..color = Color.fromRGBO(20, 108, 148, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint carbPaint = Paint()
      ..color = Color.fromRGBO(255, 21, 21, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    Paint fatPaint = Paint()
      ..color = Color.fromRGBO(250, 155, 49, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawArc(rect, 0, 2 * pi, false, backgroundPaint);

    // Draw protein arc
    double proteinSweepAngle = 2 * pi * proteinPercentage;
    canvas.drawArc(rect, startAngle, proteinSweepAngle, false, proteinPaint);

    // Draw carbs arc
    double carbSweepAngle = 2 * pi * carbPercentage;
    startAngle += proteinSweepAngle;
    canvas.drawArc(rect, startAngle, carbSweepAngle, false, carbPaint);

    // Draw fats arc
    double fatSweepAngle = 2 * pi * fatPercentage;
    startAngle += carbSweepAngle;
    canvas.drawArc(rect, startAngle, fatSweepAngle, false, fatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
