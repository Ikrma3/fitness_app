import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/tabs/bottomBar.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/food/plansScreen.dart';
import 'package:myfitness/screens/settings/CNMViewScreen.dart';

class AppDevices extends StatefulWidget {
  @override
  _AppDevicesState createState() => _AppDevicesState();
}

class _AppDevicesState extends State<AppDevices> {
  List<dynamic> featuredApps = [];
  List<dynamic> allApps = [];
  List<dynamic> connectedApps = [];
  bool isAllSelected = true;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadJsonData();
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

  Future<void> loadJsonData() async {
    final String response =
        await rootBundle.loadString('lib/json files/appDevices.json');
    final data = await json.decode(response);
    setState(() {
      featuredApps = data['featured'];
      allApps = data['allApps'];
      connectedApps = data['connectedApps'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: AppColors.getAppbarColor(context),
          surfaceTintColor: AppColors.getAppbarColor(context),
          title: Text(
            'Apps & Devices',
            style: TextStyle(
                fontSize: 19.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0.h),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Center(
                              child: Text(
                            'All',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: isAllSelected
                                  ? AppColors.getTextColor(context)
                                  : AppColors.getSubtitleColor(context),
                            ),
                          )),
                        ),
                        Container(
                          height: 1.h,
                          color: isAllSelected
                              ? Color.fromRGBO(21, 109, 149, 1)
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                              child: Text(
                            'Connected',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: isAllSelected
                                  ? AppColors.getSubtitleColor(context)
                                  : AppColors.getTextColor(context),
                            ),
                          )),
                        ),
                        Container(
                          height: 1.h,
                          color: isAllSelected
                              ? Colors.transparent
                              : Color.fromRGBO(21, 109, 149, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isAllSelected) ...[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Text(
                    'Featured',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 110.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredApps.length,
                      itemBuilder: (context, index) {
                        return FeaturedApp(
                          title: featuredApps[index]['title'],
                          image: featuredApps[index]['image'],
                          subtitle: featuredApps[index]['subTitle'],
                        );
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.all(16.0.w.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      isAllSelected ? 'All Apps' : 'Connected Apps',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter'),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Column(
                children: (isAllSelected ? allApps : connectedApps).map((app) {
                  return AppTile(
                    title: app['title'],
                    description: app['description'],
                    image: app['image'],
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }
}

class FeaturedApp extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  FeaturedApp(
      {required this.title, required this.image, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 72.h,
            width: 72.w,
          ),
          // SizedBox(height:),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 10.sp, fontFamily: 'Poppin'),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(
                width: 2.w,
              ),
              Text(subtitle,
                  style: TextStyle(fontSize: 10.sp, fontFamily: 'Poppin')),
            ],
          )
        ],
      ),
    );
  }
}

class AppTile extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  AppTile(
      {required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0.h),
      padding: EdgeInsets.all(12.w.h),
      decoration: BoxDecoration(
        gradient: AppColors.getFrameGradient(context),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 56.w,
            height: 56.h,
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      color: AppColors.getTextColor(context),
                    )),
                SizedBox(height: 5),
                Text(description,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      fontFamily: 'Inter',
                      color: AppColors.getSubtitleColor(context),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
