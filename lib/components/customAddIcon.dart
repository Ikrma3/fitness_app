import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomIconButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 22, // Adjust the width and height as needed
        height: 25,
        decoration: BoxDecoration(
          color: Color.fromRGBO(21, 109, 149, 1), // Set the background color
          shape: BoxShape.circle, // Make it circular
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
