import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/settingsComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import other screens here

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = '';
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    String jsonString =
        await rootBundle.loadString('lib/json files/profile.json');
    final data = json.decode(jsonString);
    setState(() {
      name = data['name'];
      profileImage = data['profile_image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.h), // For top spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Text('Settings',
                  style: TextStyle(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppin')),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: AssetImage(profileImage),
                  ),
                  SizedBox(height: 10.h),
                  Text(name,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter')),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              color: Color.fromRGBO(211, 234, 240, 1),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.h),
              child: Text('Profile',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 109, 149, 1),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter')),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SettingsComponent(
                      iconPath: 'images/RMF.png',
                      title: "Recipe's, Meals & Food",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RecipesScreen()),
                        // );
                      },
                    ),

                    SettingsComponent(
                      iconPath: 'images/progress.png',
                      title: "Progress",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ProgressScreen()),
                        // );
                      },
                    ),

                    SettingsComponent(
                      iconPath: 'images/report.png',
                      title: "Weekly report",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/work.png',
                      title: "Workouts",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/goal.png',
                      title: "Goals",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/nutri.png',
                      title: "Nutrition",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/appDevices.png',
                      title: "App & Devices",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/steps.png',
                      title: "Steps",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/reminder.png',
                      title: "Reminder",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/notification.png',
                      title: "Notifications",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    // Add more SettingsComponent widgets here for each menu item
                    // ...
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Color.fromRGBO(211, 234, 240, 1),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text('Settings',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 109, 149, 1),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter')),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SettingsComponent(
                      iconPath: 'images/editProfile.png',
                      title: "Edit Profile",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RecipesScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/subscription.png',
                      title: "Subscription",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ProgressScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/delete.png',
                      title: "Delete Account",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/password.png',
                      title: "Change Password",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/privacy.png',
                      title: "Privacy Center",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/about.png',
                      title: "About",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/logout.png',
                      title: "Logout",
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportScreen()),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
