import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

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
        height: 18.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0.r),
          color: widget.value
              ? Color.fromRGBO(21, 109, 149, 1)
              : AppColors.SwitchColor(context),
          boxShadow: [
            BoxShadow(
              color: AppColors.getShadowColor(context),
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
                        height: 14.0.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(255, 255, 255, 1),
                              Color.fromRGBO(232, 234, 234, 1)
                            ])),
                      )
                    : Container(
                        width: 22.0.w,
                        height: 14.0.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
