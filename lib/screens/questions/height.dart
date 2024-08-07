import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/fragmentComponent.dart';
import 'package:myfitness/components/indicators/stepIndicator.dart';
import 'package:myfitness/components/buttons/submitButton.dart';
import 'package:myfitness/screens/questions/weight.dart';

class SelectHeightScreen extends StatefulWidget {
  final List<String> userData;

  SelectHeightScreen({required this.userData});

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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => SelectWeightScreen(userData: widget.userData)),
    // );
  }

  void onContinue() {
    if (selectedUnit == 'Feet') {
      if (feet == 0 && inches == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter height')),
        );
      } else {
        List<String> updatedUserData = List.from(widget.userData);
        updatedUserData.add("Height: $feet ft $inches in");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SelectWeightScreen(userData: updatedUserData)),
        );
        print(updatedUserData);
      }
    } else if (selectedUnit == 'Centimeter') {
      if (centimeters == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter height')),
        );
      } else {
        List<String> updatedUserData = List.from(widget.userData);
        updatedUserData.add("Height: $centimeters cm");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SelectWeightScreen(userData: updatedUserData)),
        );
      }
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
        ? Color.fromRGBO(34, 35, 50, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    Color cColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Colors.white;
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
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FragmentComponent(
                      firstOption: 'Feet',
                      secondOption: 'Centimeter',
                      onSelected: onUnitSelected,
                    ),
                    SizedBox(height: 30.h),
                    if (selectedUnit == 'Feet') ...[
                      Container(
                        width: 320.w,
                        height: 64.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.w),
                          child: Row(
                            children: [
                              Container(
                                height: 64.h,
                                width: 97.w,
                                decoration: BoxDecoration(
                                    color: cColor,
                                    borderRadius: BorderRadius.circular(10.r)),
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
                                    color: tColor,
                                    fontFamily: 'Inter',
                                  ),
                                  cursorColor: tColor,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: cColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 108, 148, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "ft",
                                style: TextStyle(
                                    fontSize: 20.sp, fontFamily: 'Inter'),
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                height: 64.h,
                                width: 97.w,
                                decoration: BoxDecoration(
                                    color: cColor,
                                    borderRadius: BorderRadius.circular(10.r)),
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
                                    color: tColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                  cursorColor: tColor,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: cColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(20, 108, 148, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "in",
                                style: TextStyle(
                                    fontSize: 20.sp, fontFamily: 'Inter'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else if (selectedUnit == 'Centimeter') ...[
                      Row(
                        children: [
                          SizedBox(width: 102.w),
                          Container(
                            decoration: BoxDecoration(
                                color: cColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            height: 60.h,
                            width: 97.w,
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
                                color: tColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                              cursorColor: tColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: cColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(20, 108, 148, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
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
