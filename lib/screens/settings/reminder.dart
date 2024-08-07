import 'package:flutter/material.dart';
import 'package:myfitness/components/tabs/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/switchComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/food/plansScreen.dart';
import 'package:myfitness/screens/settings/settings.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool _breakfast = false;
  bool _lunch = true;
  bool _dinner = true;
  bool _weight = false;
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DairyScreen()),
        );
        _currentIndex = 0;
      } else if (_currentIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanScreen()),
        );
        _currentIndex = 0;
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.getAppbarColor(context),
          title: Text(
            'Reminder',
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0.w.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meals',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter'),
              ),
              Divider(color: Color.fromRGBO(211, 234, 240, 1)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Breakfast',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        '10:00 am',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                  SwitchComponent(
                    value: _breakfast,
                    onChanged: (bool value) {
                      setState(() {
                        _breakfast = value;
                        // TODO: Add your action here
                      });
                    },
                  ),
                ],
              ),
              Divider(color: Color.fromRGBO(211, 234, 240, 1)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lunch',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter')),
                      Text(
                        '10:00 am',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                  SwitchComponent(
                    value: _lunch,
                    onChanged: (bool value) {
                      setState(() {
                        _lunch = value;
                        // TODO: Add your action here
                      });
                    },
                  ),
                ],
              ),
              Divider(color: Color.fromRGBO(211, 234, 240, 1)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dinner',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter')),
                      Text(
                        '10:00 am',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                  SwitchComponent(
                    value: _dinner,
                    onChanged: (bool value) {
                      setState(() {
                        _dinner = value;
                        // TODO: Add your action here
                      });
                    },
                  ),
                ],
              ),
              Divider(color: Color.fromRGBO(211, 234, 240, 1)),
              SizedBox(height: 20.h),
              Text(
                'Weight',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter'),
              ),
              Divider(color: Color.fromRGBO(211, 234, 240, 1)),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Weekly on Mondays',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter')),
                      Text(
                        '10:00 am',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                  SwitchComponent(
                    value: _weight,
                    onChanged: (bool value) {
                      setState(() {
                        _weight = value;
                        // TODO: Add your action here
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }
}
