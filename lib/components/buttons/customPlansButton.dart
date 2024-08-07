import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? image;

  PlanButton({
    required this.text,
    required this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94.w,
      height: 24.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(124, 196, 230, 1),
            Color.fromRGBO(48, 135, 175, 1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30.0.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(20, 108, 148, 0.24),
            offset: Offset(0, 2),
            blurRadius: 2.r,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) ...[
              Padding(
                padding: EdgeInsets.only(right: 2.0.w),
                child: SizedBox(
                  width: 20.w,
                  height: 24.h,
                  child: image!,
                ),
              ),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
