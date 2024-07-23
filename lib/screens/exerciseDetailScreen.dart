import 'package:flutter/material.dart';
import 'package:myfitness/components/equipmentComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String time;
  final List<Map<String, String>> equipment;
  final String techniques;

  ExerciseDetailScreen({
    required this.title,
    required this.image,
    required this.description,
    required this.time,
    required this.equipment,
    required this.techniques,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9, // Increase the height
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20.0.w.h),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 304.h,
                      width: 320.w,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppin'),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans'),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Equipment',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppin'),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 122.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: equipment.map((item) {
                        return Padding(
                          padding: EdgeInsets.all(8.0.w.h),
                          child: Equipment(
                            imageUrl: item['image']!,
                            text: item['name']!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Exercise technique',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppin'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    techniques,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans'),
                  ),
                  SizedBox(
                      height:
                          100.h), // Add some space at the bottom for the button
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
                padding: EdgeInsets.all(20.w.h),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: Color.fromRGBO(21, 109, 149, 1), // Text color
                        fontSize: 17.sp,
                        fontFamily: 'Poppin' // Text size
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromRGBO(21, 109, 149, 1),
                    backgroundColor: Colors.white, // Text color on the button
                    side: BorderSide(
                        color: Color.fromRGBO(21, 109, 149, 1),
                        width: 1), // Border color and width
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.w, vertical: 12.h), // Button padding
                    textStyle: TextStyle(
                      fontSize: 17.sp, // Text size
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
