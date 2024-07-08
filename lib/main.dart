import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/breakFastScreen.dart';
import 'package:myfitness/screens/changePassword.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/goalScreen.dart';
import 'package:myfitness/screens/height.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/myPlans.dart';
import 'package:myfitness/screens/notifications.dart';
import 'package:myfitness/screens/onBoard.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/profile.dart';
import 'package:myfitness/screens/questionsScreen.dart';
import 'package:myfitness/screens/reminder.dart';
import 'package:myfitness/screens/settings.dart';
import 'package:myfitness/screens/signin.dart';
import 'package:myfitness/screens/signup.dart';
import 'package:myfitness/screens/subscriptionScreen.dart';
import 'package:myfitness/screens/weight.dart';

void main() {
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
            home: PasswordScreen());
      },
      // Use the system theme
    );
  }
}
