import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemesData {
  /////////////////////////////////////////////////////////////////////////////
  static double screenWidth(BuildContext ctx) => MediaQuery.of(ctx).size.width;
  /////////////////////////////////////////////////////////////////////////////
  static double screenHeight(BuildContext ctx) =>
      MediaQuery.of(ctx).size.height;
  /////////////////////////////////////////////////////////////////////////////
  static Orientation orientation(BuildContext ctx) =>
      MediaQuery.of(ctx).orientation;

  ///////////////////////////////////////////////////////////////////
  static AppBarTheme appBarTheme(Color primaryColor) {
    return AppBarTheme(
      elevation: 5,
      backgroundColor: primaryColor,
      foregroundColor: useWhiteForeground(primaryColor)
          ? Colors.white
          : Colors.black,
      titleTextStyle: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        fontFamily: 'RobotoCondensed',
        color: useWhiteForeground(primaryColor)
            ? Colors.white.withOpacity(0.9)
            : Colors.black,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////
  static BottomNavigationBarThemeData bottomNavigationBarTheme(
    Color primaryColor,
    Color accentColor,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: accentColor,
      unselectedItemColor:
          useWhiteForeground(primaryColor) ? Colors.white : Colors.black,
      selectedLabelStyle:
          createTextStyle(14, FontWeight.w600, color: accentColor),
    );
  }

  ///////////////////////////////////////////////////////////////////
  static TextStyle createTextStyle(
    double fontSize,
    FontWeight fontWeight, {
    Color color = const Color.fromRGBO(255, 255, 255, 0.8), //optional params
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'RobotoCondensed',
      fontWeight: fontWeight,
      color: color,
    );
  }

  ///////////////////////////////////////////////////////////////////
  static RadioThemeData radioThemeData() {
    return RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.grey),
    );
  }

  ///////////////////////////////////////////////////////////////////
  static IconThemeData iconThemeData(primaryColor) {
    return IconThemeData(
      color: useWhiteForeground(primaryColor)
          ? Colors.white.withOpacity(0.9)
          : Colors.black,
    );
  }

  ///////////////////////////////////////////////////////////////////

}
