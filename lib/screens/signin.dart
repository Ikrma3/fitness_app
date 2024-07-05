import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/customTextField.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/components/errorCheck.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/signup.dart';

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
                  'Sign In',
                  style: TextStyle(
                      color: const Color.fromRGBO(21, 109, 149, 1),
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'Phone/Email',
                  controller: emailController,
                  errorText: emailError,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  errorText: passwordError,
                ),
                SizedBox(height: 30.h),
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 90.h), // Some space
                Text(
                  'Sign in With',
                  style: TextStyle(
                      color: pColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('images/logos_apple.png'),
                      onPressed: () {
                        // Handle Apple sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/logos_fb.png'),
                      onPressed: () {
                        // Handle Facebook sign-in logic
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/logos_google.png'),
                      onPressed: () {
                        // Handle Google sign-in logic
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: pColor, fontSize: 14.sp, fontFamily: 'Inter'),
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
                        'Signup',
                        style: TextStyle(
                            color: Color.fromRGBO(20, 108, 148, 1),
                            fontSize: 14.sp,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
