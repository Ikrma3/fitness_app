import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularCheckbox extends StatefulWidget {
  const CircularCheckbox({Key? key}) : super(key: key);

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Row(
        children: [
          Container(
            width: 17.w,
            height: 17.h,
            decoration: BoxDecoration(

              shape: BoxShape.circle,
              border: Border.all(
                color: _isChecked ? const Color(0xff5DA6C7) : const Color(0xff5DA6C7),
                width: 0.5,
              ),
              color: _isChecked ? const Color(0xff5DA6C7) : Colors.white,
            ),
            child: _isChecked
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 20.0,
            )
                : null,
          ),
          SizedBox(width: 8.w),
          Text('By continuing you accept our Privacy Policy',style: TextStyle(color: const Color(0xff9299A3),fontWeight: FontWeight.w400,fontFamily: 'Inter',fontSize: 12.sp),)
        ],
      ),
    );
  }
}
