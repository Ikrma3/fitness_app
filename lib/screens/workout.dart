import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitness/components/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/excerciseFrame.dart';
import 'package:myfitness/components/startTraining.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/plansScreen.dart';
import 'package:myfitness/screens/settings.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List categories = [];
  List popularWorkouts = [];
  List exercises = [];
  bool viewAll = false;
  bool pViewAll = false;
  bool eViewAll = false;
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
    loadCategories();
    loadPopularWorkouts();
    loadExercises();
  }

  Future<void> loadCategories() async {
    final String response =
        await rootBundle.loadString('lib/json files/category.json');
    final data = await json.decode(response);
    setState(() {
      categories = data;
    });
  }

  Future<void> loadPopularWorkouts() async {
    final String response =
        await rootBundle.loadString('lib/json files/popularTraining.json');
    final data = await json.decode(response);
    setState(() {
      popularWorkouts = data.map((workout) {
        workout['isFavorite'] = false;
        return workout;
      }).toList();
    });
  }

  Future<void> loadExercises() async {
    final String response =
        await rootBundle.loadString('lib/json files/workoutExcercise.json');
    final data = await json.decode(response);
    setState(() {
      exercises = data;
    });
  }

  void toggleFavorite(int index) {
    setState(() {
      popularWorkouts[index]['isFavorite'] =
          !popularWorkouts[index]['isFavorite'];
      print('Favorite toggled for ${popularWorkouts[index]['title']}');
    });
  }

  void onExerciseTap(String title) {
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Workouts Routine'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.w.h),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Color(0xff404B52)),
                  decoration: InputDecoration(
                    hintText: "Search Something",
                    hintStyle:
                        TextStyle(fontSize: 14.sp, fontFamily: 'OpenSans'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(21, 109, 149, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.w,
                      ),
                    ),
                    fillColor: Color.fromRGBO(217, 237, 245, 1),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Category',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: 'Poppin',
                            fontWeight: FontWeight.w400)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          viewAll = !viewAll;
                        });
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Poppin',
                          fontWeight: FontWeight.w400,
                          color: viewAll
                              ? Color.fromRGBO(20, 108, 148, 1)
                              : Color.fromRGBO(146, 153, 163, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                viewAll ? buildListView() : buildHorizontalListView(),
                SizedBox(height: 26.h),
                StartTraining(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Popular Workouts',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Poppin',
                                fontWeight: FontWeight.w400)),
                        Text("Workouts: 80",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppin',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(64, 75, 82, 1)))
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          pViewAll = !pViewAll;
                        });
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Poppin',
                          fontWeight: FontWeight.w400,
                          color: pViewAll
                              ? Color.fromRGBO(20, 108, 148, 1)
                              : Color.fromRGBO(146, 153, 163, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                pViewAll
                    ? buildPopularWorkoutsListView()
                    : buildPopularWorkoutsHorizontalListView(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Exercises',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Poppin',
                                fontWeight: FontWeight.w400)),
                        Text("Exercises: 210",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Poppin',
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(64, 75, 82, 1)))
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          eViewAll = !eViewAll;
                        });
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Poppin',
                          fontWeight: FontWeight.w400,
                          color: eViewAll
                              ? Color.fromRGBO(20, 108, 148, 1)
                              : Color.fromRGBO(146, 153, 163, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                eViewAll ? buildExercisesListView() : buildExercisesListView(),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
        ));
  }

  Widget buildHorizontalListView() {
    return Container(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return buildCategoryCard(categories[index]);
        },
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildCategoryCard(categories[index]),
            SizedBox(
              height: 20.h,
            )
          ],
        );
      },
    );
  }

  Widget buildCategoryCard(category) {
    return GestureDetector(
      onTap: () {
        print(category['text']);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: 10.w), // Adjust margin for spacing
        padding: EdgeInsets.all(6.0.w.h),
        width: 90.w, // Adjust width to fit multiple items
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(218, 224, 232, 1)),
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(category['image'], width: 24.w, height: 24.h),
            SizedBox(height: 8.0),
            Text(category['text'],
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Poppin',
                    color: Colors.black)), // Adjust font size
          ],
        ),
      ),
    );
  }

  Widget buildPopularWorkoutsHorizontalListView() {
    return Container(
      height: 216.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularWorkouts.length,
        itemBuilder: (context, index) {
          return buildPopularWorkoutCard(popularWorkouts[index], index);
        },
      ),
    );
  }

  Widget buildPopularWorkoutsListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: popularWorkouts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildPopularWorkoutCard(popularWorkouts[index], index),
            SizedBox(
              height: 20.h,
            )
          ],
        );
      },
    );
  }

  Widget buildPopularWorkoutCard(workout, int index) {
    return GestureDetector(
      onTap: () {
        print(workout['title']);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: 10.w), // Adjust margin for spacing
        width: 240.w, // Adjust width as needed
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
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
                    child: Image.asset(workout['image'],
                        width: 240.w, height: 160.h, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 8.0.h),
                Text(workout['title'],
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Poppin',
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(height: 4.0.h),
                Row(
                  children: [
                    Text(workout['level'],
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
                    Text(workout['time'],
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
              top: 6.0.h,
              right: 6.0.w,
              child: IconButton(
                icon: Icon(
                  workout['isFavorite']
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: workout['isFavorite']
                      ? Colors.white
                      : Color.fromRGBO(218, 224, 232, 1),
                ),
                onPressed: () => toggleFavorite(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExercisesListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseFrame(
          image: exercises[index]['image'],
          title: exercises[index]['title'],
          time: exercises[index]['time'],
          onTap: () => onExerciseTap(exercises[index]['title']),
        );
      },
    );
  }
}
