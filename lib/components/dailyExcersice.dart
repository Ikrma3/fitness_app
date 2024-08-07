import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/icons/customAddIcon.dart';

class DailyExercise extends StatefulWidget {
  @override
  _DailyExerciseState createState() => _DailyExerciseState();
}

class _DailyExerciseState extends State<DailyExercise> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jsonString =
        await rootBundle.loadString('lib/json files/dailyExcersice.json');
    final jsonData = json.decode(jsonString);
    setState(() {
      data = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.17),
            Color.fromRGBO(90, 200, 250, 0.13)
          ]
        : [Color.fromRGBO(183, 207, 218, 1), Color.fromRGBO(255, 255, 255, 1)];
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      height: 110.h,
      padding: EdgeInsets.all(10.0.h.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        gradient: LinearGradient(
          colors: pColor,
          begin: Alignment.topLeft,
          end: Alignment.center,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    data!['heading'],
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: tColor,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Image.asset(
                    data!['headingIcon'],
                    width: 60.w,
                    height: 50.h,
                  ),
                ],
              ),
              SizedBox(width: 25.w),
              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data!['details'].map<Widget>((detail) {
                      return Row(
                        children: [
                          Image.asset(
                            detail['icon'],
                            width: 38.w,
                            height: 38.h,
                          ),
                          Text(
                            detail['text'],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter'),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          CustomIconButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
