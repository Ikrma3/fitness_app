import 'package:flutter/material.dart';

class CustomSubIcon extends StatelessWidget {
  final VoidCallback onPressed;

  CustomSubIcon({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32, // Adjust the width and height as needed
        height: 32,
        decoration: BoxDecoration(
          color: Color.fromRGBO(183, 198, 202, 1), // Set the background color
          shape: BoxShape.circle, // Make it circular
        ),
        child: Center(
          child: Icon(
            Icons.remove,
            color: Colors.white,
          ), // Customize the inner icon
        ),
      ),
    );
  }
}
