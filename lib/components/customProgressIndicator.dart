import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularSegmentProgressIndicator extends StatelessWidget {
  final List<Segment> segments;
  final double radius;
  final double lineWidth;
  final bool animation;

  CircularSegmentProgressIndicator({
    required this.segments,
    this.radius = 67.5,
    this.lineWidth = 20.0,
    this.animation = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(radius * 2),
      painter: _CircularSegmentPainter(
        segments: segments,
        radius: radius,
        lineWidth: lineWidth,
        animation: animation,
      ),
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
      ..strokeWidth = 15.w;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      totalSweepAngle,
      false,
      defaultPaint,
    );

    // Draw colored segments
    double startAngle = -math.pi + 10; // Start from the top
    double currentAngle = startAngle;

    for (var segment in segments) {
      final segmentPercentage = segment.percentage;
      final sweepAngle = (segmentPercentage / 100) * totalSweepAngle;

      final paint = Paint()
        ..color = segment.color ??
            Color.fromRGBO(211, 234, 240, 1) // Use grey as default color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15.w;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );

      currentAngle += sweepAngle;
    }

    // Draw percentage text in the center
    final textStyle = TextStyle(
      fontSize: radius / 2,
      fontWeight: FontWeight.bold,
    );
    final percentageText = "${totalPercentage.toStringAsFixed(1)}%";
    final textSpan = TextSpan(text: percentageText, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    // Position the text in the center
    final textCenter = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textCenter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Segment {
  final Color? color;
  final double percentage;

  Segment({this.color, required this.percentage});
}
