import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FragmentComponent extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final String? thirdOption; // Optional third option
  final ValueChanged<String> onSelected;

  FragmentComponent({
    required this.firstOption,
    required this.secondOption,
    this.thirdOption, // Accept third option
    required this.onSelected,
  });

  @override
  _FragmentComponentState createState() => _FragmentComponentState();
}

class _FragmentComponentState extends State<FragmentComponent> {
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
    Brightness brightness = Theme.of(context).brightness;
    Color boxColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(211, 234, 240, 1);

    // Determine the width based on the presence of the third option
    double containerWidth = widget.thirdOption != null ? 355.w : 270.w;
    double containerHeight = widget.thirdOption != null ? 30.h : 40.h;
    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(20.0.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Container(
              height: containerHeight,
              child: Row(
                children: [
                  _buildOption(widget.firstOption, widget.thirdOption != null),
                  _buildOption(widget.secondOption, widget.thirdOption != null),
                  if (widget.thirdOption != null)
                    _buildOption(widget.thirdOption!, true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String option, bool hasThirdOption) {
    Brightness brightness = Theme.of(context).brightness;
    Color pColor = brightness == Brightness.dark
        ? Color.fromARGB(255, 255, 255, 255)
        : Colors.black;
    Color selectedColor = brightness == Brightness.dark
        ? Color.fromRGBO(93, 166, 199, 1)
        : Colors.white;
    Color notSelectedColor = brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(211, 234, 240, 1);
    bool isSelected = selectedOption == option;

    // Adjust the padding based on the presence of the third option
    double leftRightPadding = hasThirdOption ? 23.w : 33.w;
    double subHeight = hasThirdOption ? 26.w : 32.w;
    double fSize = hasThirdOption ? 15.sp : 17.sp;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
          widget.onSelected(option);
        });
      },
      child: Container(
        height: subHeight,
        padding:
            EdgeInsets.only(left: leftRightPadding, right: leftRightPadding),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : notSelectedColor,
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: pColor,
              fontSize: fSize,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }
}
