// explorer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/caloriesExplorer.dart';
import 'package:myfitness/components/fragmentComponent.dart';
import 'package:myfitness/components/macrosExplorer.dart';
import 'package:myfitness/components/nutrientExplorer.dart'; // Ensure correct import path

class CNMViewScreen extends StatefulWidget {
  @override
  _CNMViewScreenState createState() => _CNMViewScreenState();
}

class _CNMViewScreenState extends State<CNMViewScreen> {
  String _selectedOption = 'Calories'; // Default selected option

  @override
  Widget build(BuildContext context) {
    Widget content = Container();

    switch (_selectedOption) {
      case 'Calories':
        content = CaloriesExplorer();
        break;
      case 'Nutrients':
        content = NutrientExplorer();
        break;
      case 'Macros':
        content = MacroExplorer();
        break;
      default:
        content = Container();
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 250, 255, 1),
        title: Text(
          'Calories ',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20.w.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            FragmentComponent(
              firstOption: 'Calories',
              secondOption: 'Nutrients',
              thirdOption: 'Macros',
              onSelected: (selected) {
                setState(() {
                  _selectedOption = selected;
                });
              },
            ),
            SizedBox(
                height: 10
                    .h), // Add some space between the fragment and the content
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
