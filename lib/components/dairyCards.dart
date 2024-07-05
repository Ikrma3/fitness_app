import 'package:flutter/material.dart';
import 'package:myfitness/components/customAddIcon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DairyCard extends StatelessWidget {
  final String heading;
  final String subheading;
  final String imagePath;
  final List<String> details;
  final List<String> quanDetails;
  final List<String> calDetails;
  final Function(String) onAddPressed;
  final Function(String, String) onDetailPressed;

  const DairyCard({
    Key? key,
    required this.heading,
    required this.subheading,
    required this.imagePath,
    this.details = const [],
    this.quanDetails = const [],
    this.calDetails = const [],
    required this.onAddPressed,
    required this.onDetailPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Card(
        child: Column(
          children: [
            Container(
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r),
                ),
                color: Color.fromRGBO(211, 234, 240, 1),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Container(
                    // height: 20.h,
                    // width: 23.h,
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        heading,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        subheading,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomIconButton(
                    onPressed: () {
                      onAddPressed(heading);
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  )
                ],
              ),
            ),
            if (details.isEmpty)
              Padding(
                padding: EdgeInsets.all(8.0.w.h),
                child: Text(
                  "Reminder to Have $heading",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
              ),
            if (details.isNotEmpty)
              ...details.asMap().entries.map((entry) {
                int index = entry.key;
                String detail = entry.value;
                String quanDetail =
                    quanDetails.length > index ? quanDetails[index] : '';
                String calDetail =
                    calDetails.length > index ? calDetails[index] : '';

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        detail,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter'),
                      ),
                      subtitle: Text(
                        '$quanDetail',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(102, 102, 102, 1),
                            fontFamily: 'Inter'),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${calDetail}',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(51, 51, 51, 1)),
                          ), // <- Additional text widget
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              onDetailPressed(heading, detail);
                            },
                          ),
                        ],
                      ),
                    ),

                    // Optional: Add a divider between list tiles
                  ],
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
