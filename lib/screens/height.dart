import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/stepIndicator.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/fragmentComponent.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/weight.dart';

class SelectHeightScreen extends StatefulWidget {
  @override
  _SelectHeightScreenState createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  int currentStep = 3;
  String selectedUnit = 'Feet';
  int feet = 0;
  int inches = 0;
  int centimeters = 0;

  void onSkip() {
    // Navigate to the next screen
  }

  void onContinue() {
    if (feet == 0 && inches == 0 && centimeters == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter height')),
      );
    } else {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectWeightScreen()),
        );
      });
    }

    // Navigate to the next screen
  }

  void onUnitSelected(String unit) {
    setState(() {
      selectedUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    return Scaffold(
      backgroundColor: bColor,
      appBar: AppBar(
        backgroundColor: bColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                if (currentStep > 1) {
                  currentStep--;
                }
              });
              Navigator.pop(context);
            },
          ),
        ),
        title: Center(
          child: StepIndicator(currentStep: currentStep, totalSteps: 11),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: SkipButton(onPressed: onSkip),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Select Height',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: pColor,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 20.h),
                    FragmentComponent(
                      firstOption: 'Feet',
                      secondOption: 'Centimeter',
                      // thirdOption: 'aysy',
                      onSelected: onUnitSelected,
                      // options: ['Feet', 'Centimeter'],
                    ),
                    SizedBox(height: 30.h),
                    if (selectedUnit == 'Feet') ...[
                      Container(
                        width: 230.w,
                        height: 64.h,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      feet = int.tryParse(value) ?? 0;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(211, 234, 240,
                                            1), // Border color when not focused
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 108, 148, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "ft",
                              style: TextStyle(
                                  fontSize: 20.sp, fontFamily: 'Inter'),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Container(
                                height: 64.h,
                                color: Colors.white,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      inches = int.tryParse(value) ?? 0;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(211, 234, 240,
                                            1), // Border color when not focused
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 108, 148, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "in",
                              style: TextStyle(
                                  fontSize: 20.sp, fontFamily: 'Inter'),
                            ),
                          ],
                        ),
                      ),
                    ] else if (selectedUnit == 'Centimeter') ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 102.w,
                          ),
                          Container(
                            color: Colors.white,
                            height: 60.h,
                            width: 80.h,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  centimeters = int.tryParse(value) ?? 0;
                                });
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(211, 234, 240,
                                        1), // Border color when not focused
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 108, 148, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "cm",
                            style:
                                TextStyle(fontSize: 20.sp, fontFamily: 'Inter'),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
            CustomButton(
              text: 'Continue',
              onTap: onContinue,
            ),
          ],
        ),
      ),
    );
  }
}
