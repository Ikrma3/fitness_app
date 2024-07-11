import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/stepIndicator.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/gender.dart';
import 'package:myfitness/screens/questionsScreen.dart';
import 'package:myfitness/screens/height.dart';

class DOBScreen extends StatefulWidget {
  final List<String> userData;

  DOBScreen({required this.userData});

  @override
  _DOBScreenState createState() => _DOBScreenState();
}

class _DOBScreenState extends State<DOBScreen> {
  DateTime? selectedDate;
  int currentStep = 2;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void onSkip() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SelectHeightScreen(userData: widget.userData)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Colors.white;
    Color sColor = brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(21, 109, 149, 1);
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bColor,
        title: Row(
          children: [
            SizedBox(
              width: 60.w,
            ),
            Center(
              child: StepIndicator(currentStep: currentStep, totalSteps: 11),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Select birth date',
                  style: TextStyle(
                    color: pColor,
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppin',
                  ),
                ),
                SizedBox(height: 80.h),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: 320.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: cColor,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      color: cColor,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15.w),
                        Text(
                          selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                              : 'dd/mm/yyyy',
                          style: TextStyle(
                            color: tColor,
                            fontSize: 20.sp,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(width: 150.w),
                        Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(21, 109, 149, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 360.h),
                Container(
                  width: 350.w,
                  child: CustomButton(
                    text: 'Continue',
                    onTap: () {
                      List<String> updatedUserData = List.from(widget.userData);
                      updatedUserData.add(
                          "DOB: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}");
                      print(updatedUserData);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectHeightScreen(userData: updatedUserData),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
