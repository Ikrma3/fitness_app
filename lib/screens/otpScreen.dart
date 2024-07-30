import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/colours.dart';
import 'package:myfitness/components/pageView.dart';
import 'package:myfitness/screens/gender.dart';
import 'package:myfitness/screens/questionsScreen.dart';

class OTPScreen extends StatefulWidget {
  final String initialEmail;

  OTPScreen({
    required this.initialEmail,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String email = '';
  List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  String? storedOtp;

  @override
  void initState() {
    super.initState();
    email = widget.initialEmail;
    _loadOtpData();
  }

  Future<void> _loadOtpData() async {
    String otpJson = await rootBundle.loadString('lib/json files/otp.json');
    final Map<String, dynamic> otpMap = json.decode(otpJson);
    storedOtp = otpMap['otp'];
  }

  bool _isAllOtpFilled() {
    return otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    Color bColor = brightness == Brightness.dark
        ? const Color.fromRGBO(30, 34, 53, 1)
        : const Color.fromRGBO(245, 250, 255, 1);
    void onResend() async {}

    void _verifyOtp() {
      String enteredOtp =
          otpControllers.map((controller) => controller.text).join('');
      if (enteredOtp == storedOtp) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GenderScreen()),
        );
        print("True otp");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong OTP')),
        );
      }
    }

    void _onOtpChanged(int index) {
      if (index < otpControllers.length - 1) {
        if (otpControllers[index].text.isNotEmpty) {
          FocusScope.of(context).nextFocus(); // Move focus to next TextField
        }
      } else {
        if (_isAllOtpFilled()) {
          _verifyOtp();
        }
      }
    }

    String _getMaskedInput(String input) {
      if (input.contains('@')) {
        // Mask email
        return '${input.substring(0, 2)}***${input.substring(input.indexOf('@'))}';
      } else {
        // Mask phone number
        return input.length <= 4
            ? input
            : input.replaceRange(0, input.length - 4, '*' * (input.length - 4));
      }
    }

    return Scaffold(
      backgroundColor: bColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 75.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 88.h, horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email Verification',
                      style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        // Handle change email or number logic here
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight
                                .w400, // Default color for other text parts
                          ),
                          children: [
                            TextSpan(
                              text: email.contains('@')
                                  ? 'We sent a code to your email \n${_getMaskedInput(email)} '
                                  : 'We sent a code to your number \n${_getMaskedInput(email)} ',
                            ),
                            TextSpan(
                              text: 'Change',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Color(0xff156D95), // Blue color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.getGradient(context),
                            borderRadius: BorderRadius.circular(
                                5), // Adjust the value as needed
                          ),
                          height: 55.h,
                          width: 65.w,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                  1), // Limits input to 1 character
                            ],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            controller: otpControllers[index],
                            onChanged: (_) => _onOtpChanged(index),
                            style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins'),
                            cursorColor: Colors.black,
                            cursorHeight: 40.h,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(20, 108, 148, 1),
                                  // Change this to the desired color
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    // SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 27.w, vertical: 20.h),
                      child: Row(
                        children: [
                          Text(
                            "Don't receive your code?",
                            style:
                                TextStyle(fontSize: 15.sp, fontFamily: 'Inter'),
                          ),
                          TextButton(
                            onPressed: onResend,
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                  color: const Color.fromRGBO(21, 109, 149, 1),
                                  fontSize: 15.sp,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
