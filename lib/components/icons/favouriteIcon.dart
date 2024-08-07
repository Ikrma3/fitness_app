import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteIcon extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double size;

  const FavouriteIcon({
    Key? key,
    required this.value,
    this.onChanged,
    this.size = 25.0,
    required bool isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double responsiveSize = size.w;
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: CustomPaint(
        size: Size.square(responsiveSize),
        painter: HeartPainter(value: value),
      ),
    );
  }
}

class HeartPainter extends CustomPainter {
  final bool value;

  HeartPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 1.0.w
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(211, 234, 240, 1); // Border color

    final Path path = Path();

    // Define the heart shape path
    path.moveTo(size.width / 2, size.height / 4);
    path.cubicTo(5 * size.width / 14, 0, 0, size.height / 15, size.width / 28,
        2 * size.height / 5);
    path.cubicTo(size.width / 14, 2 * size.height / 3, 3 * size.width / 7,
        5 * size.height / 6, size.width / 2, size.height);
    path.cubicTo(4 * size.width / 7, 5 * size.height / 6, 13 * size.width / 14,
        2 * size.height / 3, 27 * size.width / 28, 2 * size.height / 5);
    path.cubicTo(size.width, size.height / 15, 9 * size.width / 14, 0,
        size.width / 2, size.height / 4);
    path.close();

    // Draw only the border if not selected
    if (!value) {
      canvas.drawPath(path, paint);
      return;
    }

    // Define the gradient
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      colors: [
        Color.fromRGBO(20, 108, 148, 1),
        Color.fromRGBO(20, 108, 148, 1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Paint the heart shape with gradient
    final Paint fillPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint); // Draw border over the filled shape
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
