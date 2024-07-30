import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(child: Text('Home Page')),
        // Placeholder for your home page
        bottomNavigationBar: BottomBar(
          currentIndex: 2,
          onTap: (index) {
            // Handle bottom bar tap
          },
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomBar({required this.currentIndex, required this.onTap});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.getBackgroundColor(context),
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.home,
              color: widget.currentIndex == 0
                  ? const Color.fromRGBO(21, 109, 149, 1)
                  : const Color.fromRGBO(183, 198, 202, 1),
              size: widget.currentIndex == 0 ? 29.sp : 25.sp,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.book,
              color: widget.currentIndex == 1
                  ? const Color.fromRGBO(21, 109, 149, 1)
                  : const Color.fromRGBO(183, 198, 202, 1),
              size: widget.currentIndex == 1 ? 29.sp : 25.sp,
            ),
          ),
          label: 'Diary',
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 40.h,
            width: 60.w,

            child: AnimatedImageButton(), // Use AnimatedImageButton here
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(CupertinoIcons.square_list_fill,
                  color: widget.currentIndex == 3
                      ? const Color.fromRGBO(21, 109, 149, 1)
                      : const Color.fromRGBO(183, 198, 202, 1),
                  size: widget.currentIndex == 3 ? 29.sp : 25.sp)),
          label: 'Plans',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.all(0),
            child: Icon(
              Icons.menu,
              color: widget.currentIndex == 4
                  ? const Color.fromRGBO(21, 109, 149, 1)
                  : const Color.fromRGBO(183, 198, 202, 1),
              size: widget.currentIndex == 4 ? 29.sp : 25.sp,
            ),
          ),
          label: 'More',
        ),
      ],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: const Color.fromRGBO(21, 109, 149, 1),
      unselectedItemColor: const Color.fromRGBO(183, 198, 202, 1),
      selectedFontSize: 14.0.sp,
      unselectedFontSize: 14.0.sp,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Inter',
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: 'Inter',
      ),
      type: BottomNavigationBarType.fixed,
    );
  }
}

class AnimatedImageButton extends StatefulWidget {
  @override
  _AnimatedImageButtonState createState() => _AnimatedImageButtonState();
}

class _AnimatedImageButtonState extends State<AnimatedImageButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFirstIcon = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    setState(() {
      if (_controller.isCompleted || _controller.isDismissed) {
        _controller.forward(from: 0.0);
      }
      _isFirstIcon = !_isFirstIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: IconButton(
            icon: Icon(
                _isFirstIcon
                    ? Icons.add_box_rounded
                    : CupertinoIcons.multiply_square_fill,
                color: const Color.fromRGBO(21, 109, 149, 1),
                size: 40.sp),
            onPressed: _onPressed,
          ),
        );
      },
    );
  }
}
//
// class CustomIcon extends StatelessWidget {
//   final bool selected;
//   final double size;
//
//   CustomIcon({required this.selected, required this.size});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(size, size),
//       painter: ClipboardIconPainter(
//         color: selected
//             ? const Color.fromRGBO(21, 109, 149, 1)
//             : const Color.fromRGBO(183, 198, 202, 1),
//       ),
//     );
//   }
// }
//
// class CustomMoreIcon extends StatelessWidget {
//   final bool selected;
//   final double size;
//
//   CustomMoreIcon({required this.selected, required this.size});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(size, size),
//       painter: MoreIconPainter(
//         color: selected
//             ? const Color.fromRGBO(21, 109, 149, 1)
//             : const Color.fromRGBO(183, 198, 202, 1),
//       ),
//     );
//   }
// }

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
      const Radius.circular(4.0),
    );
    canvas.drawRRect(clipboardBase, paint);

    // Draw clipboard top
    final clipboardTop = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.35, size.height * 0.1, size.width * 0.3,
          size.height * 0.1),
      const Radius.circular(2.0),
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
