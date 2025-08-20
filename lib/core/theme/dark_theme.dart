import 'package:flutter/material.dart';
import 'package:planitt/core/theme/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  fontFamily: "Inter",
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Color(0XFF101115),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0XFF101115),
    foregroundColor: Colors.white,
    elevation: 0,
    // i want when i scroll the app bar not to be transparent and the color remain constant
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(fontFamilyFallback: ["Noto Sans Arabic"]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: DarkMoodAppColors.kSelectedItemColor,
    unselectedItemColor: DarkMoodAppColors.kUnSelectedItemColor,
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
  ),
);
