import 'package:flutter/material.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart' as Constants;

ThemeData lightTheme(BuildContext context) => ThemeData(
  fontFamily: LanguageController.getLocale(context).languageCode == "ar"
      ? Constants.arabicFont
      : Constants.arabicFont,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: LightMoodAppColors.kBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: LightMoodAppColors.kAppBar,
    foregroundColor: Colors.black,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black),
  ),
  fontFamilyFallback: const [Constants.arabicFont],

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: LightMoodAppColors.kBottomNav,
    selectedItemColor: LightMoodAppColors.kSelectedItemColor,
    unselectedItemColor: LightMoodAppColors.kUnSelectedItemColor,
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.kAddTodoColor,
    foregroundColor: Colors.black,
  ),

  // colorScheme: const ColorScheme.light(surface: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 241, 241, 241),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.kTextFieldBorderSideColor),
    ),
    hintStyle: const TextStyle(color: Colors.black54),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kAddTodoColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: LightMoodAppColors.kSurfaceColor,
  ),
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);
