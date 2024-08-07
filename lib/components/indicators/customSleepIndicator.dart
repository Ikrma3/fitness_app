import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SleepCircularSegmentProgressIndicator extends StatelessWidget {
  final List<Segment> segments;
  final double radius;
  final double lineWidth;
  final bool animation;
  final Widget centerWidget;

  SleepCircularSegmentProgressIndicator({
    required this.segments,
    this.radius = 67.5,
    this.lineWidth = 20.0,
    this.animation = true,
    required this.centerWidget,
  }) : assert(segments.length == 4, 'Must provide exactly 3 segments');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size.square(radius * 2),
          painter: _CircularSegmentPainter(
            segments: segments,
            radius: radius,
            lineWidth: lineWidth,
            animation: animation,
          ),
        ),
        Center(child: centerWidget),
      ],
    );
  }
}

class _CircularSegmentPainter extends CustomPainter {
  final List<Segment> segments;
  final double radius;
  final double lineWidth;
  final bool animation;

  _CircularSegmentPainter({
    required this.segments,
    required this.radius,
    required this.lineWidth,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double totalPercentage =
        segments.fold(0.0, (sum, segment) => sum + segment.percentage);

    // Calculate the total sweep angle to cover the entire circle
    final double totalSweepAngle = 2 * math.pi;

    // Draw default grey circle
    final defaultPaint = Paint()
      ..color = Color.fromRGBO(211, 234, 240, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      totalSweepAngle,
      false,
      defaultPaint,
    );

    // Draw colored segments
    double startAngle = math.pi / 2; // Start from the top
    double currentAngle = startAngle;

    for (var segment in segments) {
      final segmentPercentage = segment.percentage;
      final sweepAngle = (segmentPercentage / 100) * totalSweepAngle;

      final paint = Paint()
        ..color = segment.color ??
            Color.fromRGBO(211, 234, 240, 1) // Use grey as default color
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );

      currentAngle += sweepAngle;
    }

    // Fill remaining with default color if total percentage < 100%
    if (totalPercentage < 100) {
      final remainingSweepAngle =
          ((100 - totalPercentage) / 100) * totalSweepAngle;
      final paint = Paint()
        ..color = Color.fromRGBO(211, 234, 240, 1) // Default color
        ..style = PaintingStyle.stroke
        ..strokeWidth = lineWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        remainingSweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Segment {
  final Color color;
  final double percentage;

  Segment({required this.color, required this.percentage});
}
