import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/checkBox.dart';
import 'package:myfitness/components/customTextField.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/components/errorCheck.dart';
import 'package:myfitness/screens/otpScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPrivacyPolicyAccepted = false;
  String? emailError;
  String? passwordError;

  void validateSignup() {
    setState(() {
      emailError = ErrorCheck.validateEmail(emailController.text)
          ? null
          : 'Email is invalid';
      passwordError = ErrorCheck.validatePassword(passwordController.text)
          ? null
          : 'Password is invalid';
    });
    if (emailError == null && passwordError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(
            initialEmail: emailController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(30, 34, 53, 1)
        : Color.fromRGBO(245, 250, 255, 1);

    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'Full Name',
                  controller: fullNameController,
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  errorText: emailError,
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  labelText: 'Phone',
                  controller: phoneController,
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  errorText: passwordError,
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    CheckBoxWidget(
                      value: isPrivacyPolicyAccepted,
                      onChanged: (value) {
                        setState(() {
                          isPrivacyPolicyAccepted = value ?? false;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Text(
                        'By continuing you accept our privacy policy',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(146, 153, 163, 1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Sign Up',
                  onTap: () {
                    validateSignup();
                  },
                ),
                SizedBox(height: 30.h),
                Text(
                  'Sign Up With',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('images/logos_apple.png'),
                      onPressed: () {
                        // Handle Apple sign-up logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/logos_fb.png'),
                      onPressed: () {
                        // Handle Facebook sign-up logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/logos_google.png'),
                      onPressed: () {
                        // Handle Google sign-up logic
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: pColor, fontSize: 14.sp, fontFamily: 'Inter'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Color.fromRGBO(20, 108, 148, 1),
                            fontSize: 14.sp,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
