import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';

class TrainingCard extends StatefulWidget {
  final String image;
  final String title;
  final String level;
  final String time;
  final bool isFavourite;

  TrainingCard({
    required this.image,
    required this.title,
    required this.level,
    required this.time,
    required this.isFavourite,
  });

  @override
  _TrainingCardState createState() => _TrainingCardState();
}

class _TrainingCardState extends State<TrainingCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Initialize the state based on the widget's initial value
    isFavorite = widget.isFavourite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    // Print the title when the favorite state changes
    print(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // You can keep this if you still want to print the title on tap
        print(widget.title);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: 10.w), // Adjust margin for spacing
        width: 152.w,
        height: 168, // By this height not changing
        // Adjust width as needed
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(29.0.r),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    child: Image.asset(widget.image,
                        width: 152.w, height: 120.h, fit: BoxFit.cover),
                  ),
                ),
                Text(widget.title,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppin',
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                Row(
                  children: [
                    Text(widget.level,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppin',
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(21, 109, 149, 1))),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.circle_rounded,
                      size: 4.w.h,
                      color: Color.fromRGBO(64, 75, 82, 1),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(widget.time,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Poppin',
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(64, 75, 82, 1))),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 4.0.h,
              right: 4.0.w,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Colors.white
                      : Color.fromRGBO(218, 224, 232, 1),
                ),
                onPressed: _toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
