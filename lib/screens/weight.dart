import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this package
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/stepIndicator.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/fragmentComponent.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/questionsScreen.dart';

class SelectWeightScreen extends StatefulWidget {
  @override
  _SelectWeightScreenState createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  int currentStep = 4;
  String selectedUnit = '';
  double kg = 0;
  double lb = 0;

  void onSkip() {}

  void onContinue() {
    if (kg == 0 && lb == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter Weight')),
      );
    } else {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionScreen(
                    initialQuestionId: 5,
                  )),
        );
      });
      // Navigate to the next screen
    }
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
                      'Select Weight',
                      style: TextStyle(
                          color: pColor,
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter'),
                    ),
                    SizedBox(height: 20.h),
                    FragmentComponent(
                      firstOption: 'Kilogram',
                      secondOption: 'Pound',
                      onSelected: onUnitSelected,
                      // options: ['Kilogram', 'Pound'],
                    ),
                    SizedBox(height: 30.h),
                    if (selectedUnit == 'Kilogram') ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                          ),
                          Container(
                            height: 64.h,
                            width: 100.h,
                            color: Colors.white,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  kg = double.tryParse(value) ?? 0;
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
                            "kg",
                            style:
                                TextStyle(fontSize: 20.sp, fontFamily: 'Inter'),
                          ),
                        ],
                      ),
                    ] else if (selectedUnit == 'Pound') ...[
                      Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                          ),
                          Container(
                            color: Colors.white,
                            height: 64.h,
                            width: 100.h,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  lb = double.tryParse(value) ?? 0;
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
                            "lb",
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
