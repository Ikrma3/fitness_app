import 'package:flutter/material.dart';

class AppColors {
  static Color getBackgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Color.fromRGBO(245, 250, 255, 1);
  }

  static Color SearchBarColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(120, 108, 255, 0.15)
        : Color.fromRGBO(217, 237, 245, 1);
  }

  static Color getChangePasswordFieldColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(120, 108, 255, 0.15)
        : Colors.white;
  }

  static Color SwitchColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(120, 108, 255, 0.15)
        : Color.fromRGBO(211, 234, 240, 1);
  }

  static Color getAppbarColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Colors.white;
  }

  static Color getSubtitleColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(102, 102, 102, 1);
  }

  static Color getBorderColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(90, 200, 250, 0.13)
        : Color.fromRGBO(218, 224, 232, 1);
  }

  static Color getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  static Color getTextFieldTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Color(0xff404B52);
  }

  static Color getTextFieldColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(217, 237, 245, 1);
  }

  static Color getButtonTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(21, 109, 149, 1);
  }

  static Color getButtonColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(34, 35, 50, 1)
        : Colors.white;
  }

  static Color getSleepContainerColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Color.fromRGBO(45, 52, 80, 1)
        : Color.fromRGBO(245, 250, 255, 1);
  }

  static Color getShadowColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.transparent
        : Color.fromRGBO(223, 234, 237, 1);
  }

  static Color getNutrientTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(59, 59, 59, 1);
  }

  static Color getSummaryText(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.white
        : Color.fromRGBO(64, 75, 82, 1);
  }

  static LinearGradient getGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient getExploreCardGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(217, 237, 245, 1),
              Color.fromRGBO(217, 237, 245, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient getFrameGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.17),
              Color.fromRGBO(90, 200, 250, 0.13)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient getWeightStepGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.17),
              Color.fromRGBO(90, 200, 250, 0.13)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(245, 250, 255, 1),
              Color.fromRGBO(245, 250, 255, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient ContainergetGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(211, 234, 240, 1),
              Color.fromRGBO(211, 234, 240, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient ChartgetGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient SelectedGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(93, 166, 199, 1),
              Color.fromRGBO(20, 108, 148, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(93, 166, 199, 1),
              Color.fromRGBO(20, 108, 148, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient CloseGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(122, 194, 228, 1),
              Color.fromRGBO(20, 108, 148, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient subContainergetGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.15),
              Color.fromRGBO(93, 166, 199, 0.12)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(245, 250, 255, 1),
              Color.fromRGBO(245, 250, 255, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }

  static LinearGradient getTrainingGradient(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.17),
              Color.fromRGBO(90, 200, 250, 0.13)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              Color.fromRGBO(120, 108, 255, 0.17),
              Color.fromRGBO(90, 200, 250, 0.13)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
  }
}
  // Primary colors
 
