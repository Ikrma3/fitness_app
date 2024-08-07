import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/auth/otpScreen.dart';
import 'package:myfitness/components/buttons/socialmediabuttons.dart';
import 'package:myfitness/components/checkbox/circularcheckbox.dart';
import 'package:myfitness/components/customTextField.dart';
import 'package:myfitness/components/buttons/submitButton.dart';
import 'package:myfitness/components/errorCheck.dart';

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
  String? phoneError;
  String? nameError;

  void validateSignup() {
    setState(() {
      emailError = ErrorCheck.validateEmail(emailController.text)
          ? null
          : 'Email is invalid';
      passwordError = ErrorCheck.validatePassword(passwordController.text)
          ? null
          : 'Password is invalid';
      phoneError = ErrorCheck.validatePhone(phoneController.text)
          ? null
          : 'Phone no is invalid';
      nameError = ErrorCheck.validateName(fullNameController.text)
          ? null
          : 'Name is invalid';
    });

    if (!isPrivacyPolicyAccepted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Privacy Policy'),
            content: Text('Please accept the privacy policy first.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (emailError == null &&
        passwordError == null &&
        phoneError == null &&
        nameError == null) {
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
        ? const Color.fromRGBO(30, 34, 53, 1)
        : const Color.fromRGBO(245, 250, 255, 1);

    return Scaffold(
      backgroundColor: bColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 70.h),
                Text(
                  'Sign Up',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: 23.h),
                CustomTextFormField(
                  labelText: 'Full Name',
                  controller: fullNameController,
                  errorText: nameError,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  labelText: 'Email',
                  controller: emailController,
                  errorText: emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  labelText: 'Phone',
                  controller: phoneController,
                  errorText: phoneError,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  errorText: passwordError,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    CircularCheckbox(
                      onChanged: (bool value) {
                        setState(() {
                          isPrivacyPolicyAccepted = value;
                        });
                      },
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
                SizedBox(height: 40.h),
                Text(
                  'Sign Up With',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 10.h),
                const SocialMediaButtons(),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: pColor,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
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