import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

class GridCards extends StatelessWidget {
  final List<dynamic> cardsData;
  final Function(String) onTapCard;

  GridCards({required this.cardsData, required this.onTapCard});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.17),
            Color.fromRGBO(90, 200, 250, 0.13)
          ]
        : [Colors.white, Colors.white];
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.w,
          crossAxisSpacing: 10.h,
          childAspectRatio: 155.w / 120.h // Adjust the aspect ratio as needed
          ),
      itemCount: cardsData.length,
      itemBuilder: (context, index) {
        bool hasSubheading = cardsData[index]['subheading'] != null &&
            cardsData[index]['subheading'].isNotEmpty;

        return GestureDetector(
          onTap: () {
            // Pass the heading of the tapped card back to ExploreScreen
            onTapCard(cardsData[index]['heading']);
          },
          child: Container(
            height: 100.h, // Set a fixed height for the container
            width: 155.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: pColor),
              borderRadius: BorderRadius.circular(12.r),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     spreadRadius: 1,
              //     blurRadius: 5,
              //     offset: Offset(0, 3),
              //   ),
              // ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      gradient: AppColors.getExploreCardGradient(context),
                    ),
                    child: Image.asset(
                      cardsData[index]['image'],
                      height: 40.h,
                      width: 45.w,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    cardsData[index]['heading'],
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: tColor,
                    ),
                  ),
                  if (hasSubheading) ...[
                    SizedBox(height: 5.h),
                    Text(
                      cardsData[index]['subheading'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
