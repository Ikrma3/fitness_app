import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

class OldNotificationCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const OldNotificationCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h, // Set the desired height here
        margin: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 4.h),
        child: Container(
          decoration: BoxDecoration(
              gradient: AppColors.getGradient(context),
              borderRadius: BorderRadius.circular(12.r)),
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.0.w,
              ),
              child: Row(
                children: [
                  Image.asset(
                    image,
                    width: 65.w, // Adjust the width and height as needed
                    height: 65.h,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppin'),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          height: 22.h,
                          width: 62.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(93, 166, 199, 1),
                              Color.fromRGBO(20, 108, 148, 1)
                            ]),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              subtitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Poppin'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(146, 153, 163, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
