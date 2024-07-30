import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/settingsComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/appDevices.dart';
import 'package:myfitness/screens/changePassword.dart';
import 'package:myfitness/screens/deleteAccountScreen.dart';
import 'package:myfitness/screens/goalScreen.dart';
import 'package:myfitness/screens/notifications.dart';
import 'package:myfitness/screens/oldNotifications.dart';
import 'package:myfitness/screens/profile.dart';
import 'package:myfitness/screens/progress.dart';
import 'package:myfitness/screens/progressReport.dart';
import 'package:myfitness/screens/recipiesScreen.dart';
import 'package:myfitness/screens/reminder.dart';
import 'package:myfitness/screens/steps.dart';
import 'package:myfitness/screens/workout.dart';

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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.getAppbarColor(context),
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Color.fromRGBO(20, 108, 148, 1)),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Logout",
                  style: TextStyle(color: Color.fromRGBO(20, 108, 148, 1))),
              onPressed: () {
                // Call your logout function here
                _logout();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Your logout logic here
    print("User logged out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.getAppbarColor(context),
        surfaceTintColor: AppColors.getAppbarColor(context),
      ),
      backgroundColor: AppColors.getBackgroundColor(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              decoration: BoxDecoration(
                gradient: AppColors.ContainergetGradient(context),
              ),
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
              color: AppColors.getBackgroundColor(context),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipesScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/progress.png',
                      title: "Progress",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgressScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/report.png',
                      title: "Weekly report",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeeklyReportScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/work.png',
                      title: "Workouts",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/goal.png',
                      title: "Goals",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GoalScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/nutri.png',
                      title: "Nutrition",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CNMViewScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/appDevices.png',
                      title: "App & Devices",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppDevices()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/steps.png',
                      title: "Steps",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepsScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/reminder.png',
                      title: "Reminder",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReminderScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/notification.png',
                      title: "Notification",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OldNotifications()),
                        );
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
              decoration: BoxDecoration(
                gradient: AppColors.ContainergetGradient(context),
              ),
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
              color: AppColors.getBackgroundColor(context),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/notification.png',
                      title: "Notification ",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeleteAccountScreen()),
                        );
                      },
                    ),
                    SettingsComponent(
                      iconPath: 'images/password.png',
                      title: "Change Password",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordScreen()),
                        );
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
                        _showLogoutDialog(context);
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
