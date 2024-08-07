import 'package:flutter/material.dart';
import 'package:myfitness/components/colours.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.getAppbarColor(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0.r),
              topRight: Radius.circular(24.0.r),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h), // Add space for the top icon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 304.h,
                      width: 320.w,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppin'),
                  ),
                  SizedBox(height: 4.h),
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
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppin'),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    height: 110.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: equipment.map((item) {
                        return Equipment(
                          imageUrl: item['image']!,
                          text: item['name']!,
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    'Exercise technique',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(20.w.h),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.CloseGradient(context),
                        borderRadius: BorderRadius.circular(24.r)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(
                            color: AppColors.getButtonTextColor(
                                context), // Text color
                            fontSize: 17.sp,
                            fontFamily: 'Poppin' // Text size
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromRGBO(21, 109, 149, 1),
                        // Text color on the button
                        side: BorderSide(
                            color: Color.fromRGBO(21, 109, 149, 1),
                            width: 1), // Border color and width
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 12.h), // Button padding
                        textStyle: TextStyle(
                          fontSize: 17.sp, // Text size
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8.h, // Position the line icon at the top center
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 40.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.5.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showExerciseDetailScreen(
      BuildContext context, ExerciseDetailScreen screen) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return screen;
      },
    );
  }
}
