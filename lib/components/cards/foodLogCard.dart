import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodLogCard extends StatelessWidget {
  final List<dynamic> cardsData;
  final Function(String) onTapCard;

  FoodLogCard({required this.cardsData, required this.onTapCard});

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
          mainAxisSpacing: 5.w,
          crossAxisSpacing: 10.h,
          childAspectRatio: 110.w / 70.h // Adjust the aspect ratio as needed
          ),
      itemCount: cardsData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Pass the heading of the tapped card back to ExploreScreen
            onTapCard(cardsData[index]['heading']);
          },
          child: Container(
            // Set a fixed height for the container

            decoration: BoxDecoration(
              gradient: LinearGradient(colors: pColor),
              borderRadius: BorderRadius.circular(12.r),

              // ],
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0.w.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: tColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
