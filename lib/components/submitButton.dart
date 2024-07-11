import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget? image;

  CustomButton({
    required this.text,
    required this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(124, 196, 230, 1),
                Color.fromRGBO(20, 108, 148, 1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.2, 1.0]),
          borderRadius: BorderRadius.circular(30.0.r),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(20, 108, 148, 0.24),
              offset: Offset(0, 5),
              blurRadius: 2.r,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
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
                    height: 20.h,
                    child: image!,
                  ),
                ),
              ],
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
