import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/signin.dart';

class TrainingPlanScreen extends StatefulWidget {
  @override
  _TrainingPlanScreenState createState() => _TrainingPlanScreenState();
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0.75).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(234, 248, 255, 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(120, 108, 255, 0.15),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(30.0.w.h),
              child: Container(
                child: Text(
                  'We create your training plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: pColor,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200.w, // This will determine the size of the circle
                  width: 200.w,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 23.w,
                        strokeCap: StrokeCap.round,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(93, 166, 199, 1),
                        ),
                        backgroundColor: Color.fromARGB(237, 255, 255, 255),
                      );
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Text(
                      '${(_animation.value * 100).round()}%',
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: Text(
                "We create a workout according to demographic profile, activity level and interests",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp, color: pColor, fontFamily: 'Inter'),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: CustomButton(
                text: 'Continue',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
