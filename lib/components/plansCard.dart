import 'package:flutter/material.dart';
import 'package:myfitness/screens/planDetailsScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Replace with actual import path

class PlansCardComponent extends StatelessWidget {
  final String pngImage; // Variable to hold PNG image asset path
  final String heading;
  final String subHeading;
  final List<dynamic> overview;
  final List<dynamic> schedule;

  PlansCardComponent({
    required this.pngImage, // Use pngImage for PNG images
    required this.heading,
    required this.subHeading,
    required this.overview,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanDetailsScreen(
              imagePath: pngImage, // Pass pngImage to PlanDetailsScreen
              heading: heading,
              subHeading: subHeading,
              overview: overview.cast<Map<String, dynamic>>(),
              schedule: schedule.cast<Map<String, dynamic>>(),
            ),
          ),
        );
      },
      child: SizedBox(
        width: 320.w,
        height: 200.h,
        child: Card(
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 320.w,
                height: 134.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0.r),
                    topRight: Radius.circular(10.0.r),
                  ),
                  child: Image.asset(
                    pngImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0.w.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                      SizedBox(height: 2.h),
                      Text(subHeading,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
