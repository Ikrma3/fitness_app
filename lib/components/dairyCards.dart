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
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.15),
            Color.fromRGBO(93, 166, 199, 0.12)
          ]
        : [Color.fromRGBO(211, 234, 240, 1), Color.fromRGBO(211, 234, 240, 1)];
    List<Color> cColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.17),
            Color.fromRGBO(90, 200, 250, 0.13)
          ]
        : [Colors.white, Colors.white];
    Color tColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(51, 51, 51, 1);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: cColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Container(
                height: 42.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: pColor)),
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
                        SizedBox(height: 2.h),
                        Text(
                          heading,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter'),
                        ),
                        Text(
                          subheading,
                          style: TextStyle(
                              fontSize: 10.sp,
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
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detail,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter'),
                              ),
                              Text(
                                '$quanDetail',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: tColor,
                                    fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${calDetail}',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: tColor),
                            ), // <- Additional text widget
                            PopupMenuButton<String>(
                              color: Colors.white,
                              icon: Icon(Icons.more_vert),
                              onSelected: (String result) {
                                switch (result) {
                                  case 'Edit':
                                    // Handle edit action
                                    onEditPressed(heading, detail);
                                    break;
                                  case 'Delete':
                                    // Handle delete action
                                    onDeletePressed(heading, detail);
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),

                      // Optional: Add a divider between list tiles
                    ],
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void onDeletePressed(String heading, String detail) {}

  void onEditPressed(String heading, String detail) {}
}
