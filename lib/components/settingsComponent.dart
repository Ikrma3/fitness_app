import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsComponent extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  SettingsComponent(
      {required this.iconPath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: ListTile(
        leading:
            Container(height: 38.h, width: 38.w, child: Image.asset(iconPath)),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
