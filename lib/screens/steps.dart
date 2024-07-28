import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/customAddIcon.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';

class StepsScreen extends StatefulWidget {
  @override
  _StepsScreenState createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  late String imageUrl;
  late String title;
  late String subtitle;
  late int dailyStepsGoal;
  bool isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
          MaterialPageRoute(builder: (context) => CNMViewScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  Future<void> fetchData() async {
    final String response =
        await rootBundle.loadString('lib/json files/deviceSteps.json');

    final data = await json.decode(response);
    setState(() {
      imageUrl = data['image'];
      title = data['title'];
      subtitle = data['subtitle'];
      dailyStepsGoal = data['dailyStepsGoal'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Steps',
            style: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      "Additional Information",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: 88.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(imageUrl, width: 56.w, height: 56.h),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter')),
                                Container(
                                  width: 210.w,
                                  child: Text(subtitle,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          fontFamily: 'Inter',
                                          color:
                                              Color.fromRGBO(102, 102, 102, 1)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            Spacer(),
                            Checkbox(
                              value: true,
                              activeColor: Color.fromRGBO(21, 109, 149, 1),
                              onChanged: (bool? value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0.w.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomIconButton(
                              onPressed: () {
                                print("Removed");
                              },
                            ),
                            SizedBox(width: 10.w),
                            Text('Add Device',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter')),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 35.w),
                            Text(
                              "Connect Your step tracker to MyyFitnessPal",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(102, 102, 102, 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  GestureDetector(
                    onTap: () {
                      print("Track off");
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0.w.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.do_not_disturb,
                            size: 21.w.h,
                            color: Color.fromRGBO(21, 109, 149, 1),
                          ),
                          SizedBox(width: 10),
                          Text("Don't Track Steps",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter')),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.w.h),
                    child: TextButton(
                      onPressed: () {
                        print("Deleted");
                      },
                      child: Text('Delete Account',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              color: Colors.black)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0.w.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text('Daily Steps Goal $dailyStepsGoal',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                color: Colors.black)),
                        Spacer(),
                        Text('$dailyStepsGoal',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(21, 109, 149, 1)))
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }
}
