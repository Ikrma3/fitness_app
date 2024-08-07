import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/auth/signup.dart';
import 'package:myfitness/components/buttons/socialmediabuttons.dart';
import 'package:myfitness/components/customTextField.dart';

import 'package:myfitness/components/buttons/submitButton.dart';
import 'package:myfitness/components/errorCheck.dart';
import 'package:myfitness/screens/home.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  void validateAndSignIn() {
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
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      // Proceed with sign-in logic
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? const Color.fromRGBO(30, 34, 53, 1)
        : const Color(0xffF8FAFC);

    return Scaffold(
      backgroundColor: bColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 110.h),
                Text(
                  'Sign In',
                  style: TextStyle(
                      color: const Color(0xff156D95),
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  labelText: 'Phone/Email',
                  controller: emailController,
                  errorText: emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                    labelText: 'Password',
                    obscureText: true,
                    controller: passwordController,
                    errorText: passwordError,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'Sign In',
                  onTap: validateAndSignIn,
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    // Handle forgot password logic here
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: pColor,
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 80.h), // Some space
                Text(
                  'Sign in With',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 10.h),
                const SocialMediaButtons(),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: pColor,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: const Color.fromRGBO(20, 108, 148, 1),
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
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
