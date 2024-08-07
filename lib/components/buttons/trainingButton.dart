import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainingButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  TrainingButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 36.h,
        width: 147.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(131, 197, 228, 1),
              Color.fromRGBO(53, 125, 158, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontFamily: 'Poppin',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
