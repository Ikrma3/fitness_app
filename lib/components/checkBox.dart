import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckBoxWidget({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(73, 87, 112, 1)
        : Color.fromRGBO(211, 234, 240, 1);
    return GestureDetector(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: value
              ? LinearGradient(
                  colors: [
                    Color.fromRGBO(93, 166, 199, 1),
                    Color.fromRGBO(20, 108, 148, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          border: Border.all(
            color: value ? Colors.transparent : cColor,
            width: 2.w,
          ),
        ),
        width: 19.w,
        height: 19.h,
        child: value
            ? Center(
                child: CustomPaint(
                  size: Size(8.w, 8.h),
                  painter: TickPainter(),
                ),
              )
            : null,
      ),
    );
  }
}

class TickPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5.w
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.w, size.height * 0.45.h);
    path.lineTo(size.width * 0.25.w, size.height * 0.65.h);
    path.lineTo(size.width * 0.75.w, size.height * 0.25.h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
