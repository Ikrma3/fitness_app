import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitness/components/checkBox.dart';
import 'package:myfitness/components/frame.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/foodScreen.dart';

class PlanDetails extends StatefulWidget {
  final Map<String, dynamic> selectedPlan;

  PlanDetails({required this.selectedPlan});

  @override
  _PlanDetailsState createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {
  List<String> weeks = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"];
  String selectedWeek = "Week 1";
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int selectedFrameIndex = -1; // Track selected frame index

  @override
  Widget build(BuildContext context) {
    List<DateTime> currentWeekDates = getDatesOfSelectedWeek();

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          widget.selectedPlan['name'],
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: selectedWeek,
            icon: Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedWeek = newValue!;
                // Update the date range based on the selected week
                currentWeekDates = getDatesOfSelectedWeek();
                selectedDate =
                    DateFormat('yyyy-MM-dd').format(currentWeekDates[0]);
              });
            },
            items: weeks.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 90.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentWeekDates.length,
              itemBuilder: (context, index) {
                DateTime date = currentWeekDates[index];
                bool isSelected =
                    DateFormat('yyyy-MM-dd').format(date) == selectedDate;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w,
                      vertical: 10.h,
                    ),
                    child: Container(
                      // Adding space between rows
                      child: Column(
                        children: [
                          Text(
                            DateFormat('E').format(date)[0],
                          ), // Use first letter of the day
                          CheckBoxWidget(
                            value: isSelected,
                            onChanged: (bool? newValue) {
                              setState(() {
                                selectedDate =
                                    DateFormat('yyyy-MM-dd').format(date);
                              });
                            },
                          ),
                          Text(DateFormat('d').format(date)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    _buildSection("Breakfast"),
                    SizedBox(
                      height: 25.h,
                    ),
                    _buildSection("Lunch"),
                    SizedBox(
                      height: 25.h,
                    ),
                    _buildSection("Snacks"),
                    SizedBox(
                      height: 25.h,
                    ),
                    _buildSection("Dinner"),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> getDatesOfSelectedWeek() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    int startDay = 1;
    int endDay = 7;

    switch (selectedWeek) {
      case "Week 1":
        startDay = 1;
        endDay = 7;
        break;
      case "Week 2":
        startDay = 8;
        endDay = 14;
        break;
      case "Week 3":
        startDay = 15;
        endDay = 21;
        break;
      case "Week 4":
        startDay = 22;
        endDay = 28;
        break;
      case "Week 5":
        startDay = 29;
        endDay = daysInMonth; // Last day of the month
        break;
    }

    DateTime firstDateOfMonth = DateTime(now.year, now.month, 1);
    DateTime startDate = firstDateOfMonth.add(Duration(days: startDay - 1));
    DateTime endDate = firstDateOfMonth.add(Duration(days: endDay - 1));

    return List<DateTime>.generate(
      endDay - startDay + 1,
      (index) => startDate.add(Duration(days: index)),
    );
  }

  Widget _buildSection(String mealType) {
    final planDataForSelectedDate = widget.selectedPlan['data'][selectedDate];
    if (planDataForSelectedDate == null ||
        planDataForSelectedDate[mealType] == null) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 20.w),
          child: Text(
            mealType,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
        ),
        ...(planDataForSelectedDate[mealType] as List)
            .asMap()
            .entries
            .map<Widget>((entry) {
          int index = entry.key;
          dynamic item = entry.value;
          bool isSelected = selectedFrameIndex == index;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedFrameIndex == index) {
                    selectedFrameIndex = -1; // Deselect if already selected
                  } else {
                    selectedFrameIndex = index; // Select this frame
                  }
                });
              },
              child: Frame(
                image: item['image'],
                name: mealType,
                text: item['text'],
                favourite: true,
                subtitle: '${item['calories']} cal',
                many: true,
                currentSelections: 0,
                isSelected: isSelected,
                onChanged: (isChecked) {
                  isChecked = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodScreen(
                        title: item['text'],
                        image: item['image'],
                        protein: item['protein'],
                        carbs: item['carbs'],
                        fats: item['fats'],
                        meal: mealType,
                        time: item['time'],
                        dailyGoals: {
                          "protein": item['dailyGoals']['protein'],
                          "carbs": item['dailyGoals']['carbs'],
                          "fats": item['dailyGoals']['fats'],
                          "totalProtein": item['dailyGoals']['totalProtein'],
                          "totalCarb": item['dailyGoals']['totalCarb'],
                          "totalFat": item['dailyGoals']['totalFat'],
                        },
                      ),
                    ),
                  ).then((_) {
                    // Reset the selection state when coming back
                    setState(() {
                      selectedFrameIndex = -1;
                    });
                  });
                },
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
