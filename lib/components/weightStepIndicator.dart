import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGraph extends StatelessWidget {
  final String heading;
  final String subHeading;
  final int value;
  final String date;

  CustomGraph(
      {required this.heading,
      required this.value,
      required this.date,
      required this.subHeading});

  @override
  Widget build(BuildContext context) {
    List<int> yAxisValues = [];
    Color lineColor = Color.fromRGBO(178, 178, 178, 1);

    // Determine y-axis values and line color based on heading
    if (heading.toLowerCase() == 'weight') {
      // Define y-axis values for weight
      yAxisValues = [value - 5, value, value + 5, value + 10];
    } else if (heading.toLowerCase() == 'steps') {
      // Define y-axis values for steps
      yAxisValues = [1000, 2000, 5000, 9000];
    }

    // Generate x-axis dates
    List<String> xAxisDates = generateXAxisDates(date);

    // Determine line color based on value
    if (yAxisValues.contains(value)) {
      lineColor = Color.fromRGBO(21, 109, 149, 1);
    } else if (heading.toLowerCase() == 'steps' &&
        value >= yAxisValues.first &&
        value <= yAxisValues.last) {
      // If value is between y-axis values for steps, determine nearest points
      lineColor = Color.fromRGBO(21, 109, 149, 1);
    }

    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  textAlign: TextAlign.justify,
                  heading,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                        textAlign: TextAlign.justify,
                        subHeading,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(178, 178, 178, 1),
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 160.w,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        CustomPaint(
          size: Size(280.w, 140.h), // Adjust size as needed
          painter: GraphPainter(
            yAxisValues: yAxisValues,
            lineColor: lineColor,
            xAxisDates: xAxisDates,
            value: value,
            heading: heading,
          ),
        ),
      ],
    );
  }

  List<String> generateXAxisDates(String latestDate) {
    // Split the date string into day and month parts
    List<String> parts = latestDate.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);

    // Generate past three months' dates
    List<String> dates = [];
    for (int i = 0; i < 4; i++) {
      int adjustedMonth = month - i;
      int adjustedYear = day;

      if (adjustedMonth < 1) {
        adjustedMonth += 12;
        adjustedYear -= 1;
      }

      dates.add(
        '${adjustedYear.toString()}/${adjustedMonth.toString().padLeft(2, '0')}',
      );
    }

    return dates.reversed.toList();
  }
}

class GraphPainter extends CustomPainter {
  final List<int> yAxisValues;
  final Color lineColor;
  final List<String> xAxisDates;
  final int value;
  final String heading;

  GraphPainter({
    required this.yAxisValues,
    required this.lineColor,
    required this.xAxisDates,
    required this.value,
    required this.heading,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Drawing horizontal lines based on yAxisValues
    Paint linePaint = Paint()
      ..color = Color.fromRGBO(178, 178, 178, 1)
      ..strokeWidth = 1.0;

    double ySpacing = size.height / (yAxisValues.length - 1);

    for (int i = 0; i < yAxisValues.length; i++) {
      double yPos = size.height - (i * ySpacing);
      canvas.drawLine(Offset(50.w, yPos), Offset(size.width, yPos), linePaint);

      // Draw y-axis labels with spacing
      TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right,
      );
      textPainter.text = TextSpan(
        text: yAxisValues[i].toString(),
        style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Inter',
          color: Color.fromRGBO(178, 178, 178, 1),
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas,
          Offset(1.w, yPos - textPainter.height / 2)); // Adjust spacing here
    }

    // Check if value matches any exact y-axis point
    if (yAxisValues.contains(value)) {
      Paint blueLinePaint = Paint()
        ..color = lineColor
        ..strokeWidth = 2.0;

      double yPos = size.height - (yAxisValues.indexOf(value) * ySpacing);

      canvas.drawLine(
        Offset(50.w, yPos),
        Offset(size.width, yPos),
        blueLinePaint,
      );

      // Draw a small blue circle at the end of the blue line
      canvas.drawCircle(Offset(size.width, yPos), 4, blueLinePaint);
    } else if (heading.toLowerCase() == 'steps' &&
        value >= yAxisValues.first &&
        value <= yAxisValues.last) {
      // If value is between y-axis values for steps, determine nearest points
      int lowerValue = yAxisValues.lastWhere((y) => y <= value,
          orElse: () => yAxisValues.first);
      int upperValue = yAxisValues.firstWhere((y) => y >= value,
          orElse: () => yAxisValues.last);

      Paint blueLinePaint = Paint()
        ..color = lineColor
        ..strokeWidth = 2.0;

      double lowerYPos =
          size.height - (yAxisValues.indexOf(lowerValue) * ySpacing);
      double upperYPos =
          size.height - (yAxisValues.indexOf(upperValue) * ySpacing);

      double ratio = (value - lowerValue) / (upperValue - lowerValue);
      double blueLineYPos = lowerYPos + ratio * (upperYPos - lowerYPos);

      canvas.drawLine(
        Offset(50.w, blueLineYPos),
        Offset(size.width, blueLineYPos),
        blueLinePaint,
      );

      // Draw a small blue circle at the end of the blue line
      canvas.drawCircle(Offset(size.width, blueLineYPos), 4, blueLinePaint);
    }

    // Drawing x-axis dates
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
    );

    double xInterval = size.width / (xAxisDates.length);
    for (int i = 0; i < xAxisDates.length; i++) {
      textPainter.text = TextSpan(
        text: xAxisDates[i],
        style: TextStyle(
          fontSize: 12.sp,
          color: i == xAxisDates.length - 1
              ? Color.fromRGBO(21, 109, 149, 1)
              : Color.fromRGBO(178, 178, 178, 1),
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(xInterval * i + 50,
            size.height + 20), // Adjust space before x-axis here
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
