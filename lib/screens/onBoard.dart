import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:myfitness/components/submitButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/screens/signin.dart';
import 'package:myfitness/screens/subscriptionScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<dynamic> _data = [];
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
        await rootBundle.rootBundle.loadString('lib/json files/onBoard.json');
    final data = await json.decode(response);
    setState(() {
      _data = data['data'];
    });
  }

  void _nextIndex() {
    if (_currentIndex < _data.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentIndex == _data.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SubscriptionScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Colors.white;

    if (_data.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 10),
            child: Image.asset(
              _data[_currentIndex]['image'],
              key: ValueKey<int>(_currentIndex),
              fit: BoxFit.fill,
              width: 360.w,
              height: _currentIndex == 0 ? 410.h : 415.h,
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final currentData = _data[index];
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: _currentIndex == 0 ? 350.h : 300.h,
                      decoration: BoxDecoration(
                        color: cColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  currentData['heading'],
                                  key: ValueKey<int>(_currentIndex),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              SizedBox(height: 14.h),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: Text(
                                  currentData['text'],
                                  key: ValueKey<int>(_currentIndex),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: pColor,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              if (_currentIndex != _data.length) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _data.length,
                                    (index) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      width: 9.w,
                                      height: 9.h,
                                      decoration: BoxDecoration(
                                        color: index == _currentIndex
                                            ? Color.fromRGBO(21, 109, 149, 1)
                                            : Color.fromRGBO(211, 234, 240, 1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                              ],
                              CustomButton(
                                  text: 'Get Started', onTap: _nextIndex),
                              if (_currentIndex == 0) ...[
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                          color: pColor,
                                          fontSize: 16.sp,
                                          fontFamily: 'Inter'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen()),
                                        );
                                      },
                                      child: Text(
                                        'Signin',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(20, 108, 148, 1),
                                            fontSize: 16.sp,
                                            fontFamily: 'Inter'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    )
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
