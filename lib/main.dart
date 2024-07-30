import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/appDevices.dart';
import 'package:myfitness/screens/breakFastScreen.dart';
import 'package:myfitness/screens/changePassword.dart';
import 'package:myfitness/screens/deleteAccountScreen.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/gender.dart';
import 'package:myfitness/screens/goalScreen.dart';
import 'package:myfitness/screens/height.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/myPlans.dart';
import 'package:myfitness/screens/notifications.dart';
import 'package:myfitness/screens/oldNotifications.dart';
import 'package:myfitness/screens/onBoard.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/profile.dart';
import 'package:myfitness/screens/progress.dart';
import 'package:myfitness/screens/progressReport.dart';
import 'package:myfitness/screens/questionsScreen.dart';
import 'package:myfitness/screens/recipiesScreen.dart';
import 'package:myfitness/screens/reminder.dart';
import 'package:myfitness/screens/settings.dart';
import 'package:myfitness/screens/signin.dart';
import 'package:myfitness/screens/signup.dart';
import 'package:myfitness/screens/sleepScreen.dart';
import 'package:myfitness/screens/steps.dart';
import 'package:myfitness/screens/subscriptionScreen.dart';
import 'package:myfitness/screens/summary.dart';
import 'package:myfitness/screens/trainingScreen.dart';
import 'package:myfitness/screens/weight.dart';
import 'package:myfitness/screens/workout.dart';
import 'package:myfitness/screens/workoutDetails.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (__, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(), // Default light theme
            darkTheme: ThemeData.dark(), // Default dark theme
            themeMode: ThemeMode.system,
            home: OnBoardingScreen());
      },
      // Use the system theme
    );
  }
}
