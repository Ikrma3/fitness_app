import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class NutrientExplorer extends StatefulWidget {
  @override
  _NutrientExplorerState createState() => _NutrientExplorerState();
}

class _NutrientExplorerState extends State<NutrientExplorer> {
  List<dynamic> nutrientData = [];
  int currentIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadNutrientData();
  }

  Future<void> loadNutrientData() async {
    String data =
        await rootBundle.loadString('lib/json files/nutrientExplorer.json');
    setState(() {
      nutrientData = json.decode(data);
      _updateIndexByDate(_selectedDate); // Update index based on initial date
    });
  }

  void _updateIndexByDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    for (int i = 0; i < nutrientData.length; i++) {
      if (nutrientData[i]['date'] == formattedDate) {
        setState(() {
          currentIndex = i;
        });
        break;
      }
    }
  }

  bool _isToday(String date) {
    DateTime today = DateTime.now();
    DateTime parsedDate =
        DateTime.parse(date); // Assuming date is in ISO 8601 format

    return today.year == parsedDate.year &&
        today.month == parsedDate.month &&
        today.day == parsedDate.day;
  }

  void _navigateDate(int direction) {
    setState(() {
      currentIndex += direction;
      if (currentIndex < 0) {
        currentIndex = 0;
      } else if (currentIndex >= nutrientData.length) {
        currentIndex = nutrientData.length - 1;
      }
      _selectedDate = DateTime.parse(nutrientData[currentIndex]['date']);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2030, 12),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _updateIndexByDate(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (nutrientData.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var currentData = nutrientData[currentIndex];
    DateTime currentDate = DateTime.parse(currentData['date']);
    String displayDate = _isToday(currentData['date'])
        ? 'Today'
        : DateFormat('dd/MM/yyyy').format(currentDate);

    List<Color> progressColors = [
      Color.fromRGBO(108, 13, 143, 1),
      Color.fromRGBO(153, 153, 153, 1),
      Color.fromRGBO(250, 155, 49, 1),
      Color.fromRGBO(0, 102, 238, 1),
      Color.fromRGBO(44, 185, 176, 1),
      Color.fromRGBO(255, 60, 60, 1),
      Color.fromRGBO(255, 57, 235, 1)
    ];

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 250, 255, 1),
      body: Padding(
        padding: EdgeInsets.all(6.0.w.h),
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(245, 250, 255, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromRGBO(204, 204, 204, 1),
                    ),
                    onPressed: () => _navigateDate(1),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Column(
                          children: [
                            Text('Day View',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color.fromRGBO(102, 102, 102, 1),
                                    fontFamily: 'Inter')),
                            Text(displayDate,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter')),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(204, 204, 204, 1),
                    ),
                    onPressed: () => _navigateDate(-1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: Color.fromRGBO(21, 109, 149, 1),
              ),
              padding: EdgeInsets.all(4.0.w.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text('Nutrients',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Left',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: currentData['nutrients'].length,
                  itemBuilder: (context, index) {
                    var nutrient = currentData['nutrients'][index];
                    double progress = nutrient['total'] / nutrient['goal'];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                flex: 10,
                                child: Text(nutrient['name'],
                                    style: TextStyle(
                                      color: Color.fromRGBO(59, 59, 59, 1),
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                    )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text('${nutrient['total']} mg',
                                    style: TextStyle(
                                      color: Color.fromRGBO(59, 59, 59, 1),
                                      fontSize: 13.sp,
                                      fontFamily: 'Inter',
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('${nutrient['goal']}',
                                    style: TextStyle(
                                      color: Color.fromRGBO(59, 59, 59, 1),
                                      fontSize: 13.sp,
                                      fontFamily: 'Inter',
                                    )),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    '${nutrient['goal'] - nutrient['total']}',
                                    style: TextStyle(
                                      color: Color.fromRGBO(59, 59, 59, 1),
                                      fontSize: 13.sp,
                                      fontFamily: 'Inter',
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w, vertical: 2.0.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                height: 3.h,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        color: Color.fromRGBO(211, 234, 240, 1),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: progress *
                                          MediaQuery.of(context).size.width,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: progressColors[
                                              index % progressColors.length],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
