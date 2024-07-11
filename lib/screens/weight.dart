import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/stepIndicator.dart';
import 'package:myfitness/components/skipButton.dart';
import 'package:myfitness/components/fragmentComponent.dart';
import 'package:myfitness/components/submitButton.dart';
import 'package:myfitness/screens/diagnosed.dart';
import 'package:myfitness/screens/questionsScreen.dart';

class SelectWeightScreen extends StatefulWidget {
  final List<String> userData;

  SelectWeightScreen({required this.userData});

  @override
  _SelectWeightScreenState createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  int currentStep = 4;
  String selectedUnit = '';
  double kg = 0;
  double lb = 0;

  void onSkip() {
    // Implement skip functionality if needed
  }

  void onContinue() {
    if (selectedUnit == 'Kilogram') {
      if (kg == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter Weight')),
        );
      } else {
        List<String> updatedUserData = List.from(widget.userData);
        updatedUserData.add("Weight: $kg kg");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Diagnosed(userData: updatedUserData)),
        );
        print(updatedUserData);
      }
    } else if (selectedUnit == 'Pound') {
      if (lb == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter Weight')),
        );
      } else {
        // Convert pounds to kilograms for consistency
        double weightInKg = lb * 0.453592; // 1 lb = 0.453592 kg
        List<String> updatedUserData = List.from(widget.userData);
        updatedUserData.add("Weight: ${weightInKg.toStringAsFixed(2)} kg");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Diagnosed(userData: updatedUserData)),
        );
        print(updatedUserData);
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
                            width: 97.h,
                            decoration: BoxDecoration(
                                color: cColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
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
                                  color: tColor,
                                  fontFamily: 'Inter'),
                              cursorColor: tColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color: cColor,
                                    // Border color when not focused
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
                            decoration: BoxDecoration(
                                color: cColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            height: 64.h,
                            width: 97.h,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  lb = double.tryParse(value) ?? 0;
                                });
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: tColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter'),
                              cursorColor: tColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(
                                    color:
                                        cColor, // Border color when not focused
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
