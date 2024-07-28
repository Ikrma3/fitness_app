import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function()? onSuffixIconTap;

  const CustomTextFormField({
    required this.controller,
    required this.errorText,
    required this.labelText,
    this.obscureText = false,
    required this.keyboardType,
    required this.textInputAction,
    this.onSuffixIconTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 320.w,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: const TextStyle(color: Color(0xff404B52)),
        decoration: InputDecoration(
          labelText: errorText ?? labelText,
          labelStyle: TextStyle(
            color: errorText != null ? Colors.red : const Color(0xff404B52),
            fontSize: 15.sp,
          ),
          suffixIcon: onSuffixIconTap != null
              ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide(
              color: Color.fromRGBO(217, 237, 245, 1),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide(
              color: Color.fromRGBO(217, 237, 245, 1),
              width: 1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.r),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.w,
            ),
          ),
          fillColor: Color.fromRGBO(217, 237, 245, 1),
          filled: true,
          errorText: errorText != null ? '' : null,
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }
}
