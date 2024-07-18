import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportFragmentComponent extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final String? thirdOption; // Optional third option
  final ValueChanged<String> onSelected;

  ReportFragmentComponent({
    required this.firstOption,
    required this.secondOption,
    this.thirdOption, // Accept third option
    required this.onSelected,
  });

  @override
  _ReportFragmentComponentState createState() =>
      _ReportFragmentComponentState();
}

class _ReportFragmentComponentState extends State<ReportFragmentComponent> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.firstOption; // Initialize with the first option
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.onSelected(selectedOption); // Notify the parent widget
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine the width based on the presence of the third option
    double containerWidth = 303.w;
    double containerHeight = 40.h;
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: containerHeight,
            child: Row(
              children: [
                _buildOption(widget.firstOption, widget.thirdOption != null),
                _buildOption(widget.secondOption, widget.thirdOption != null),
                VerticalDivider(
                  color: Color.fromRGBO(211, 234, 240, 1),
                  width: 1,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                _buildOption(widget.thirdOption!, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String option, bool hasThirdOption) {
    bool isSelected = selectedOption == option;

    // Adjust the padding based on the presence of the third option
    double fSize = 14.sp;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
          widget.onSelected(option);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
        child: Container(
          width: 90.w,
          height: 32.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSelected
                  ? [
                      Color.fromRGBO(93, 166, 199, 1),
                      Color.fromRGBO(20, 108, 148, 1)
                    ]
                  : [Colors.white, Colors.white],
            ),
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Center(
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:
                      isSelected ? Colors.white : Color.fromRGBO(64, 75, 82, 1),
                  fontSize: fSize,
                  fontFamily: 'Poppin',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
