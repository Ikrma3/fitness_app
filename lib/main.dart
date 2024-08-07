import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/splashScreen.dart';

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
            home: SplashScreen());
      },
      // Use the system theme
    );
  }
}
