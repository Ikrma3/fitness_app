import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/oldNotificationsCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OldNotifications extends StatefulWidget {
  @override
  _OldNotificationsState createState() => _OldNotificationsState();
}

class _OldNotificationsState extends State<OldNotifications> {
  Map<String, dynamic> notifications = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
        await rootBundle.loadString('lib/json files/oldNotifications.json');
    final data = await json.decode(response);
    setState(() {
      notifications = data['notifications'];
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
          'Notifications',
          style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter'),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.keys.length,
        itemBuilder: (context, index) {
          String date = notifications.keys.elementAt(index);
          List<dynamic> items = notifications[date];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0.w.h),
                child: Text(
                  date,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'OpenSans'),
                ),
              ),
              ...items.map((item) {
                return OldNotificationCard(
                  image: item['image'],
                  title: item['title'],
                  subtitle: item['subtitle'],
                  onTap: () {
                    print(item['title']);
                  },
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
