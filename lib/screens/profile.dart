import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> profileData = {};

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    String jsonString =
        await rootBundle.loadString('lib/json files/profile.json');
    setState(() {
      profileData = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (profileData.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppin'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0.w.h),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: AssetImage(profileData['profile_image']),
                  ),
                  Text(
                    profileData['name'],
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ProfileItem(
                        imagePath: 'images/weight.png',
                        text: profileData['weight'],
                      ),
                      ProfileItem(
                        imagePath: 'images/person.png',
                        text: profileData['height_cm'],
                      ),
                      ProfileItem(
                        imagePath: 'images/cake.png',
                        text: profileData['age'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromRGBO(211, 234, 240, 1),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.h),
              child: Text('Profile',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 109, 149, 1),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter')),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    buildProfileItem('Name', profileData['name']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Height', profileData['height_ft_in']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Sex', profileData['sex']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem(
                        'Date of Birth', profileData['date_of_birth']),
                    Divider(
                      indent: 30.w,
                      endIndent: 30.w,
                      color: Color.fromRGBO(211, 234, 240, 1),
                    ),
                    buildProfileItem('Location', profileData['location']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Time Zone', profileData['time_zone']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Units', profileData['units']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                    buildProfileItem('Email', profileData['email']),
                    Divider(
                        indent: 30.w,
                        endIndent: 30.w,
                        color: Color.fromRGBO(211, 234, 240, 1)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(String label, String value) {
    return Container(
      //color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: 'Inter'),
            ),
            Text(value,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'Inter')),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String imagePath;
  final String text;

  const ProfileItem({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96.w,
      height: 76.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath, width: 30.w, height: 30.h),
          SizedBox(height: 4.h),
          Text(
            text,
            style: TextStyle(fontSize: 14.sp, fontFamily: 'Poppin'),
          ),
        ],
      ),
    );
  }
}
