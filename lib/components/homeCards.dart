import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  final Map<String, dynamic> cardData;
  final bool isActive;
  final double height;
  final double width;

  const HomeCard({
    required this.cardData,
    required this.isActive,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  int calculateRemaining(int goal, int food, int exercise) {
    return goal - food + exercise;
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    List<Color> pColor = brightness == Brightness.dark
        ? [
            Color.fromRGBO(120, 108, 255, 0.17),
            Color.fromRGBO(90, 200, 250, 0.13)
          ]
        : [Color.fromRGBO(211, 234, 240, 1), Color.fromRGBO(255, 255, 255, 1)];
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    bool hasImages = cardData['details'] != null &&
        cardData['details'].isNotEmpty &&
        cardData['details'][0]['image'] != null;

    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: pColor,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(19.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardData['heading'] ?? '',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: tColor,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            cardData['subHeading'] ?? '',
            style: TextStyle(
              fontSize: 12.sp,
              color: tColor,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 16.h),
          if (hasImages)
            buildWithImages(context)
          else
            buildWithoutImages(context),
        ],
      ),
    );
  }

  Widget buildWithImages(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    int goal = cardData['details'][0]['value'];
    int food = cardData['details'][1]['value'];
    int exercise = cardData['details'][2]['value'];
    double remaining = calculateRemaining(goal, food, exercise).toDouble();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(140.w, 140.h),
                painter: CircularProgressPainter(
                  progress: remaining / goal,
                  goal: goal,
                  remaining: remaining,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    remaining.toString(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: tColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    'Remaining',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: tColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cardData['details']
                .map<Widget>((detail) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            detail['image'] != null
                                ? SvgPicture.asset(
                                    detail['image'],
                                    height: 26.h,
                                    width: 25.w,
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(width: 15.w),
                            Text(
                              '${detail['title']}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Inter',
                                color: tColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40.w),
                            Text(
                              ' ${detail['value']}',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                  color: tColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          ),
        ),
      ],
    );
  }

  Widget buildWithoutImages(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    Color tColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    List<Color> colors = [
      const Color.fromRGBO(20, 108, 148, 1),
      const Color.fromRGBO(250, 155, 49, 1),
      const Color.fromRGBO(244, 66, 55, 1)
    ];
    List<String> units = ['g', 'g', 'g'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(cardData['progress'].length, (index) {
            var progress = cardData['progress'][index];
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 75.w,
                      child: CircularProgressIndicator(
                        value: progress['value'] / 300.0,
                        strokeWidth: 8.w,
                        strokeCap: StrokeCap.round,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colors[index]),
                        backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${progress['value']}',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter'),
                        ),
                        Text(
                          units[index],
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${progress['name']}',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color.fromRGBO(59, 59, 59, 1),
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 10.h,
                          color: colors[index],
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${progress['value']}${units[index]}',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: tColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double remaining;
  final int goal;

  CircularProgressPainter({
    required this.progress,
    required this.remaining,
    required this.goal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 10.0.w;
    double radius = (size.width / 2) - strokeWidth;

    Paint backgroundPaint = Paint()
      ..color = const Color.fromRGBO(230, 230, 230, 1)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint remainingPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromRGBO(255, 2, 2, 1),
          Color.fromRGBO(20, 108, 148, 1),
          Color.fromRGBO(20, 108, 148, 1)
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    double startAngle = -90 * (2.80 / 180);
    double sweepAngle = 360 * progress * (3.14 / 180);
    double remainingAngle = 360 * (remaining / goal) * (3.14 / 180);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, progressPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        remainingAngle, false, remainingPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
