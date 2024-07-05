import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfitness/components/pageView.dart';
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
        ? Color.fromRGBO(30, 34, 53, 1)
        : Color.fromRGBO(245, 250, 255, 1);
    void onResend() async {}

    void _verifyOtp() {
      String enteredOtp =
          otpControllers.map((controller) => controller.text).join('');
      if (enteredOtp == storedOtp) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuestionScreen(
                    initialQuestionId: 1,
                  )),
        );
        print("True otp");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong OTP')),
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: bColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 88.h, horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Email Verification',
                    style: TextStyle(
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    email.contains('@')
                        ? 'We sent a code to your email \n(${_getMaskedInput(email)})'
                        : 'We sent a code to your number \n(${_getMaskedInput(email)})',
                    style: TextStyle(fontSize: 16.sp, fontFamily: 'Inter'),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      'Change',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Color.fromRGBO(21, 109, 149, 1),
                          fontFamily: 'Inter'),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Container(
                        color: Colors.white,
                        height: 64.h,
                        width: 65.w,
                        child: TextField(
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: otpControllers[index],
                          onChanged: (_) => _onOtpChanged(index),
                          style: TextStyle(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter'),
                          cursorColor: Colors.black,
                          cursorHeight: 32.h,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                            counter: SizedBox.shrink(),
                            focusedBorder: OutlineInputBorder(
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
                    padding: EdgeInsets.symmetric(horizontal: 27.w),
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
                                color: Color.fromRGBO(21, 109, 149, 1),
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
        ),
      ),
    );
  }
}
