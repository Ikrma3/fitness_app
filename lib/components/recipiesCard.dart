import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeCard extends StatefulWidget {
  final dynamic recipe;
  final VoidCallback onTap;
  final Function(dynamic) onSave;

  RecipeCard({required this.recipe, required this.onTap, required this.onSave});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0, // Light shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          child: Container(
            color: Colors.white,
            width: 134.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)),
                  child: Image.asset(
                    widget.recipe['image'],
                    height: 144.h,
                    width: 134.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    widget.recipe['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Row(
                    children: [
                      Text(
                        '${widget.recipe['calories']} cal',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter'),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                          widget.onSave(widget.recipe);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
