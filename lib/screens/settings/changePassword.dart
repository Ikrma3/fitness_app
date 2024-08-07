import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

import 'package:myfitness/components/buttons/submitButton.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscuredNewPassword = true;
  bool _isObscuredConfirmPassword = true;
  String? _errorMessage;

  void _validatePasswords() {
    setState(() {
      if (_newPasswordController.text.length < 10) {
        _errorMessage = 'Weak Password';
      } else if (_newPasswordController.text !=
          _confirmPasswordController.text) {
        _errorMessage = 'Your passwords do not match';
      } else {
        _errorMessage = null;
      }
    });
  }

  void _handleSubmit() {
    _validatePasswords();
    if (_errorMessage == null) {
      print('Password: ${_newPasswordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "New Password",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Mulish'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _newPasswordController,
                  obscureText: _isObscuredNewPassword,
                  decoration: InputDecoration(
                    hintText: 'Input your new password',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(183, 198, 202, 1),
                        fontSize: 14.sp,
                        fontFamily: 'Mulish'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                      borderSide:
                          BorderSide(color: Color.fromRGBO(183, 198, 202, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(183, 198, 202, 1),
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(20, 108, 148, 1),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscuredNewPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isObscuredNewPassword
                            ? Color.fromRGBO(183, 198, 202, 1)
                            : Color.fromRGBO(20, 108, 148, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscuredNewPassword = !_isObscuredNewPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.getChangePasswordFieldColor(context),
                  ),
                  onChanged: (_) => _validatePasswords(),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '10 characters minimum',
                      style: TextStyle(
                          color: Color.fromRGBO(17, 20, 45, 1),
                          fontSize: 10.sp,
                          fontFamily: 'Mulish'),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Mulish'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isObscuredConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(183, 198, 202, 1),
                        fontSize: 14.sp,
                        fontFamily: 'Mulish'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(183, 198, 202, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(183, 198, 202, 1),
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(20, 108, 148, 1),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscuredConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _isObscuredConfirmPassword
                            ? Color.fromRGBO(183, 198, 202, 1)
                            : Color.fromRGBO(20, 108, 148, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscuredConfirmPassword =
                              !_isObscuredConfirmPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.getChangePasswordFieldColor(context),
                  ),
                  onChanged: (_) => _validatePasswords(),
                ),
                SizedBox(height: 10.h),
                if (_errorMessage != null)
                  Row(
                    children: [
                      SizedBox(width: 10.w),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10.sp,
                            fontFamily: 'Mulish'),
                      ),
                    ],
                  ),
              ],
            ),
            CustomButton(
              text: 'Change Password',
              onTap: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
