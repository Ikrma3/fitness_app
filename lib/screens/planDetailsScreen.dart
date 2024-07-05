import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/screens/CNMViewScreen.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/home.dart';
import 'package:myfitness/screens/plansScreen.dart';

class PlanDetailsScreen extends StatefulWidget {
  final String imagePath;
  final String heading;
  final String subHeading;
  final List<Map<String, dynamic>> overview;
  final List<Map<String, dynamic>> schedule;

  PlanDetailsScreen({
    required this.imagePath,
    required this.heading,
    required this.subHeading,
    required this.overview,
    required this.schedule,
  });

  @override
  _PlanDetailsScreenState createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  bool isOverviewSelected = true;
  int _currentIndex = 3;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DairyScreen()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanScreen()),
        );
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CNMViewScreen()),
        );
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            // Use Stack to overlay AppBar on top of Image
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Stack(
                children: [
                  // Image Container
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // AppBar
                  Positioned(
                    top: -15.h,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      elevation: 0,

                      backgroundColor:
                          Color.fromARGB(60, 0, 0, 0), // Transparent AppBar
                      title: Text(
                        'Plans Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Plan heading
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.w.h),
                  child: Text(
                    textAlign: TextAlign.start,
                    widget.heading,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Toggle buttons (Overview / Schedule)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOverviewSelected = true;
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70.w,
                          ),
                          Text(
                            'Overview',
                            style:
                                TextStyle(fontSize: 15.sp, fontFamily: 'Inter'),
                          ),
                          SizedBox(
                            width: 65.w,
                          ),
                        ],
                      ),
                      if (isOverviewSelected)
                        Container(
                          height: 1.h,
                          width: 155.w,
                          color: Color.fromRGBO(21, 109, 149, 1),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOverviewSelected = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        'Schedule',
                        style: TextStyle(fontSize: 15.sp, fontFamily: 'Inter'),
                      ),
                      if (!isOverviewSelected)
                        Container(
                          height: 1.h,
                          width: 155.w,
                          color: Color.fromRGBO(21, 109, 149, 1),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Expanded content (Overview / Schedule)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20),
                  child:
                      isOverviewSelected ? _buildOverview() : _buildSchedule(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }

  // Helper method to build Overview section
  Widget _buildOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.overview.first['text'],
          style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
        ),
        SizedBox(height: 10.h),
        if (widget.overview.any((item) => item.containsKey('duration')))
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Duration:',
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                  ),
                  Spacer(),
                  Text(
                    '${widget.overview.firstWhere((item) => item.containsKey('duration'))['duration']}',
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        if (widget.overview.any((item) => item.containsKey('timesPerWeek')))
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Times Per Week:',
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                  ),
                  Spacer(),
                  Text(
                    '${widget.overview.firstWhere((item) => item.containsKey('timesPerWeek'))['timesPerWeek']}',
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              )
            ],
          ),
        if (widget.overview.any((item) => item.containsKey('difficulty')))
          Row(
            children: [
              Text(
                'Difficulty:',
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
              ),
              Spacer(),
              Text(
                '${widget.overview.firstWhere((item) => item.containsKey('difficulty'))['difficulty']}',
                style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
              ),
            ],
          ),
        SizedBox(height: 10),
        ...widget.overview.skip(1).map((item) {
          if (item['heading'] == 'Choose This Plan If' ||
              item['heading'] == 'What You Will Do') {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['heading'],
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ...item['text'].split('\n').map(
                        (line) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Flexible(
                              child: Text(
                                line,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  SizedBox(
                    height: 10.h,
                  )
                ]);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.containsKey('heading'))
                  Text(
                    item['heading'],
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                  ),
                SizedBox(
                  height: 10.h,
                ),
                if (item.containsKey('text'))
                  Text(
                    item['text'],
                    style: TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                  ),
                SizedBox(height: 10.h),
              ],
            );
          }
        }).toList(),
      ],
    );
  }

  // Helper method to build Schedule section
  Widget _buildSchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.schedule.map((item) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.containsKey('heading'))
              Text(
                item['heading'],
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter'),
              ),
            if (item.containsKey('text'))
              Text(
                item['text'],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                ),
              ),
            SizedBox(height: 10.h),
          ],
        );
      }).toList(),
    );
  }
}
