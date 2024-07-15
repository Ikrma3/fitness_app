import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/customAddIcon.dart';
import 'package:myfitness/components/foodLogCard.dart';

class BreakFastScreen extends StatefulWidget {
  @override
  _BreakFastScreenState createState() => _BreakFastScreenState();
}

class _BreakFastScreenState extends State<BreakFastScreen> {
  int _selectedIndex = 0;
  List<dynamic> _cardsData = [
    {"heading": "Scan a Meal", "subheading": "", "image": "images/camera.png"},
    {"heading": "Recipes", "subheading": "", "image": "images/res.png"},
  ];
  List<Map<String, String>> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final String response =
        await rootBundle.loadString('lib/json files/dairyBreakfast.json');
    final data = json.decode(response) as List<dynamic>;

    setState(() {
      _suggestions = List.generate(data[0]['details'].length, (index) {
        return {
          'detail': data[0]['details'][index],
          'quantity': data[0]['quanDetails'][index],
          'calories': data[0]['calDetails'][index],
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PopupMenuButton<String>(
              child: Row(
                children: [
                  SizedBox(
                    width: 60.w,
                  ),
                  Text(
                    'Breakfast',
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter'),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              onSelected: (value) {
                // Handle menu item selection
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 3',
                    child: Text('Option 3'),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w.h),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(21, 109, 149, 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromRGBO(21, 109, 149, 1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(21, 109, 149, 1),
                      width: 2.0), // Focused border color
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildChoiceChip(0, 'All'),
              _buildChoiceChip(1, 'My Meals'),
              _buildChoiceChip(2, 'My Recipes'),
              _buildChoiceChip(3, 'My Foods'),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
          if (_selectedIndex == index)
            Container(
              height: 2.h,
              width: 60.w,
              color: Color.fromRGBO(21, 109, 149, 1),
              margin: EdgeInsets.only(top: 4.h),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedIndex == 0) {
      return ListView(
        padding: EdgeInsets.all(10.0.w.h),
        children: [
          FoodLogCard(
            cardsData: _cardsData,
            onTapCard: (value) {
              print(value);
            },
          ),
          SizedBox(height: 20.h),
          Text(
            'Suggestions',
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter'),
          ),
          SizedBox(height: 10.h),
          ..._suggestions
              .map((item) => _buildSuggestionCardForBreakFast(item))
              .toList(),
        ],
      );
    } else {
      // Provide different content for other choices
      return Center(
        child: Text(
            'Content for ${_selectedIndex == 1 ? 'My Meals' : _selectedIndex == 2 ? 'My Recipes' : 'My Foods'}'),
      );
    }
  }

  Widget _buildSuggestionCardForBreakFast(Map<String, String> item) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                item['detail'] ?? '',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter'),
              ),
              subtitle: Text(
                '${item['quantity'] ?? ''}',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontFamily: 'Inter'),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${item['calories'] ?? ''}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ), // <- Additional text widget
                  CustomIconButton(
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
