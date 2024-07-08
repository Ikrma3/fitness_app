import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchComponent extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchComponent({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SwitchComponentState createState() => _SwitchComponentState();
}

class _SwitchComponentState extends State<SwitchComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 40.0.w,
        height: 15.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0.r),
          color: widget.value
              ? Color.fromRGBO(21, 109, 149, 1)
              : Color.fromRGBO(211, 234, 240, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1.r,
              blurRadius: 3.r,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              top: 2.0.h,
              left: widget.value ? 25.0.w : 3.0.w,
              right: widget.value ? 3.0.w : 25.0.w,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: widget.value
                    ? Container(
                        width: 19.0.w,
                        height: 12.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        width: 19.0.w,
                        height: 12.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
