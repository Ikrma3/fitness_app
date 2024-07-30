import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/trainingCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/settings.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  List<dynamic> trainingData = [];
  Map<String, dynamic> data = {};
  String selectedCategory = 'Beginner';
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DairyScreen()),
        );
        _currentIndex = 0;
      } else if (_currentIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanScreen()),
        );
        _currentIndex = 0;
      } else if (index == 4) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
        await rootBundle.loadString('lib/json files/training.json');
    data = await json.decode(response);
    setState(() {
      trainingData = data[selectedCategory];
    });
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      trainingData = data[category] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.getBackgroundColor(context),
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Trainings',
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter'),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 38.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryButton(
                      category: 'Beginner',
                      selectedCategory: selectedCategory,
                      onSelected: onCategorySelected),
                  CategoryButton(
                      category: 'Irregular Treanings',
                      selectedCategory: selectedCategory,
                      onSelected: onCategorySelected),
                  CategoryButton(
                      category: 'Medium',
                      selectedCategory: selectedCategory,
                      onSelected: onCategorySelected),
                  CategoryButton(
                      category: 'Advanced',
                      selectedCategory: selectedCategory,
                      onSelected: onCategorySelected),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600.w ? 3 : 2,
                  childAspectRatio:
                      152.w / 168.h, // Adjust to match your card's aspect ratio
                ),
                itemCount: trainingData.length,
                itemBuilder: (context, index) {
                  return TrainingCard(
                    image: trainingData[index]['image'],
                    title: trainingData[index]['title'],
                    level: trainingData[index]['level'],
                    time: trainingData[index]['time'],
                    isFavourite: trainingData[index]['isFavourite'],
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final String selectedCategory;
  final Function(String) onSelected;

  CategoryButton({
    required this.category,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = category == selectedCategory;

    return GestureDetector(
      onTap: () => onSelected(category),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0.w),
        decoration: BoxDecoration(
          gradient: isSelected
              ? null
              : LinearGradient(
                  colors: [
                    Color.fromRGBO(93, 166, 199, 1),
                    Color.fromRGBO(20, 108, 148, 1)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isSelected ? Colors.white : null,
          borderRadius: BorderRadius.circular(30.0.r),
        ),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              category,
              style: TextStyle(
                  fontSize: 12.sp,
                  color:
                      isSelected ? Color.fromRGBO(64, 75, 82, 1) : Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppin'),
            ),
          ),
        ),
      ),
    );
  }
}
