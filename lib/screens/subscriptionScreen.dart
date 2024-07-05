import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/checkBox.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/signin.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  Map<String, dynamic>? _data;
  bool _isMonthlySelected = false;
  bool _isYearlySelected = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.rootBundle
        .loadString('lib/json files/subscription.json');
    final data = json.decode(response);
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Colors.white;
    return Scaffold(
      body: _data != null
          ? Stack(
              children: [
                if (_data!['backgroundImage'] != null) ...[
                  Image.asset(
                    _data!['backgroundImage'],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: cColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: _buildSubscriptionContent(),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSubscriptionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _data!['heading'] ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'),
        ),
        SizedBox(height: 10.h),
        Text(
          _data!['text'] ?? '',
          style: TextStyle(fontSize: 16.sp, fontFamily: 'Inter'),
        ),
        SizedBox(height: 20.h),
        if (_data!['benefits'] != null) ...[
          for (var benefit in _data!['benefits']) ...[
            Row(
              children: [
                CheckBoxWidget(
                  value: true,
                  onChanged: (value) {
                    setState(() {
                      value = true;
                    });
                  },
                ),
                SizedBox(
                  width: 7.w,
                ),
                Text(
                  textAlign: TextAlign.center,
                  benefit['text'] ?? '',
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'Inter'),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ],
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPlanContainer(
              _data!['monthlyPlan']['heading'] ?? '',
              '\$${_data!['monthlyPlan']['price'] ?? ''}',
              _data!['monthlyPlan']['subtext'] ?? '',
              isSelected: _isMonthlySelected,
              onTap: () {
                setState(() {
                  _isMonthlySelected = !_isMonthlySelected;
                  _isYearlySelected = false; // Reset yearly selection
                });
                print('Selected Monthly plan');
              },
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildPlanContainer(
                  _data!['yearlyPlan']['heading'] ?? '',
                  '\$${_data!['yearlyPlan']['price'] ?? ''}',
                  _data!['yearlyPlan']['subtext'] ?? '',
                  isSelected: _isYearlySelected,
                  onTap: () {
                    setState(() {
                      _isYearlySelected = !_isYearlySelected;
                      _isMonthlySelected = false; // Reset monthly selection
                    });
                    print('Selected Yearly plan');
                  },
                ),
                Positioned(
                  top: -10.h,
                  right: 10.w,
                  child: _buildDiscountBadge(),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        CustomButton(
            text: 'Continue',
            onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  )
                }),
      ],
    );
  }

  Widget _buildPlanContainer(
    String heading,
    String price,
    String subtext, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Colors.white;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: MediaQuery.of(context).size.width * 0.4,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: cColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: isSelected
                  ? Color.fromRGBO(93, 166, 199, 1)
                  : Color.fromRGBO(211, 234, 240, 1),
              width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heading,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: isSelected ? pColor : Color.fromRGBO(21, 109, 149, 1),
                  fontFamily: 'Inter'),
            ),
            SizedBox(height: 5.h),
            Text(
              price,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? pColor : Color.fromRGBO(21, 109, 149, 1),
                  fontFamily: 'Inter'),
            ),
            SizedBox(height: 5.h),
            Text(
              subtext,
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.grey, fontFamily: 'Inter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
      width: 62.w,
      height: 16.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(106, 92, 255, 0.8),
            Color.fromRGBO(90, 200, 250, 0.8)
          ])),
      child: Text(
        'Save 70%',
        style: TextStyle(
            color: Color.fromRGBO(21, 109, 149, 1),
            fontSize: 8.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter'),
      ),
    );
  }
}
