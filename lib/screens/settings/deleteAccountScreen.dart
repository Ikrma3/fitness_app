import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/tabs/bottomBar.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/screens/diaryScreen.dart';
import 'package:myfitness/screens/food/plansScreen.dart';
import 'package:myfitness/screens/settings/CNMViewScreen.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _passwordController = TextEditingController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
          MaterialPageRoute(builder: (context) => CNMViewScreen()),
        );
        _currentIndex = 0;
      }
    });
    // Handle navigation to different screens here based on index
    // For now, we just print the index to console.
    print('Tab $index selected');
  }

  void deleteAccount() {
    print('Delete Account Function Triggered');
    // Add your delete account logic here
  }

  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
    deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
          backgroundColor: AppColors.getBackgroundColor(context),
          appBar: AppBar(
            backgroundColor: AppColors.getAppbarColor(context),
            surfaceTintColor: AppColors.getAppbarColor(context),
            title: Text(
              'Delete Account',
              style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter'),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: AppColors.getAppbarColor(context),
                  height: 253.h,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Mi vitae eros interdum vestibulum cursus metus elementum mauris. Vitae donec pellentesque ante hac. Sed id varius non mattis. A tortor massa mi ut et nisl arcu mattis. Mauris sit viverra quam orci.\nFacilisis sit in et porttitor lacus vitae non. Cras nunc velit pretium penatibus leo convallis justo. Lacus mauris ut a quisque. At erat quam velit at quid sed quis morbi facilisis consectetur. Lacus vitae gravida sapien fringilla. Gravida lorem neque vestibulum diam. Pharetra elit iaculis risus non integer.',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Additional Information',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        fontFamily: 'Inter'),
                  ),
                ),
                Container(
                  color: AppColors.getAppbarColor(context),
                  width: 360.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('How to cancel your subscription?');
                          },
                          child: Text(
                            'How to cancel your subscription?',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(20, 108, 148, 1)),
                          ),
                        ),
                        Divider(
                          color: Color.fromRGBO(211, 234, 240, 1),
                        ),
                        TextButton(
                          onPressed: () {
                            print('Any problem with your current account?');
                          },
                          child: Text(
                            'Any problem with your current account?',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(20, 108, 148, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        fontFamily: 'Inter'),
                  ),
                ),
                Container(
                  color: AppColors.getAppbarColor(context),
                  height: 200.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("Enter your password to delete your account.",
                            style: TextStyle(
                                fontSize: 14.sp, fontFamily: 'Inter')),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 14.sp, fontFamily: 'Inter'),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(21, 109, 149, 1)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(21, 109, 149, 1)),
                            ),
                          ),
                          onEditingComplete: deleteAccount,
                        ),
                        TextButton(
                          onPressed: () {
                            print('Forgot Password');
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(20, 108, 148, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
          )),
    );
  }
}
