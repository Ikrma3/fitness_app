import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: widget.currentIndex == 0
                ? Color.fromRGBO(21, 109, 149, 1)
                : Color.fromRGBO(183, 198, 202, 1),
            size: 25.sp,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book,
            color: widget.currentIndex == 1
                ? Color.fromRGBO(21, 109, 149, 1)
                : Color.fromRGBO(183, 198, 202, 1),
            size: 25.sp,
          ),
          label: 'Dairy',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(21, 109, 149, 1),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(
            selected: widget.currentIndex == 3,
            size: 25.sp,
          ),
          label: 'Plans',
        ),
        BottomNavigationBarItem(
          icon: CustomMoreIcon(
            selected: widget.currentIndex == 4,
            size: 25.sp,
          ),
          label: 'More',
        ),
      ],
      selectedItemColor: Color.fromRGBO(21, 109, 149, 1),
      unselectedItemColor: Color.fromRGBO(183, 198, 202, 1),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 14.0.sp,
      unselectedFontSize: 14.0.sp,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Inter',
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final bool selected;
  final double size;

  CustomIcon({required this.selected, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: ClipboardIconPainter(
        color: selected
            ? Color.fromRGBO(21, 109, 149, 1)
            : Color.fromRGBO(183, 198, 202, 1),
      ),
    );
  }
}

class CustomMoreIcon extends StatelessWidget {
  final bool selected;
  final double size;

  CustomMoreIcon({required this.selected, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: MoreIconPainter(
        color: selected
            ? Color.fromRGBO(21, 109, 149, 1)
            : Color.fromRGBO(183, 198, 202, 1),
      ),
    );
  }
}

class ClipboardIconPainter extends CustomPainter {
  final Color color;

  ClipboardIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw clipboard base
    final clipboardBase = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.3, size.width * 0.6,
          size.height * 0.7),
      Radius.circular(4.0),
    );
    canvas.drawRRect(clipboardBase, paint);

    // Draw clipboard top
    final clipboardTop = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.35, size.height * 0.1, size.width * 0.3,
          size.height * 0.1),
      Radius.circular(2.0),
    );
    canvas.drawRRect(clipboardTop, paint);

    // Draw lines on clipboard
    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final lineHeight = size.height * 0.05;
    final lineWidth = size.width * 0.4;
    final lineSpacing = size.height * 0.1;

    for (int i = 0; i < 3; i++) {
      final lineRect = Rect.fromLTWH(size.width * 0.3,
          (size.height * 0.35 + i * lineSpacing), lineWidth, lineHeight);
      canvas.drawRect(lineRect, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MoreIconPainter extends CustomPainter {
  final Color color;

  MoreIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the "More" icon (three horizontal lines)
    final lineHeight = size.height * 0.1;
    final lineWidth = size.width * 0.6;
    final spacing = size.height * 0.3;

    for (int i = 0; i < 3; i++) {
      canvas.drawRect(
        Rect.fromLTWH(size.width * 0.2, i * spacing + lineHeight / 2, lineWidth,
            lineHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
