import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:myfitness/auth/onBoard.dart';
import 'package:myfitness/components/colours.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Delay to show the splash screen for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to match the splash screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.getAppbarColor(
            context), // Match the dark green color in your image
      ),
    );

    return Scaffold(
      body: Container(
        color: AppColors.getAppbarColor(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 200.h),
              Image.asset(
                'assets/logo/splash1.png',
                width: 157.w,
                height: 159.h,
              ),
              SizedBox(height: 170.h),
              Image.asset(
                'assets/icons/icon_splash2.png',
                width: 204.w,
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
