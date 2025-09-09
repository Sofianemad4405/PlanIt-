import 'package:flutter/material.dart';
import 'package:planitt/app/controllers/language_controller.dart';
import 'package:planitt/core/theme/app_colors.dart';
import 'package:planitt/core/utils/constants.dart';

ThemeData darkTheme(BuildContext context) => ThemeData(
  fontFamily: LanguageController.getLocale(context).languageCode == "ar"
      ? arabicFont
      : englishFont,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: DarkMoodAppColors.kScaffoldColor,

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white),
  ),
  fontFamilyFallback: const ["Noto Sans Arabic"],
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: DarkMoodAppColors.kButtomNavBar,
    selectedItemColor: DarkMoodAppColors.kSelectedItemColor,
    unselectedItemColor: DarkMoodAppColors.kUnSelectedItemColor,
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.kAddTodoColor,
    foregroundColor: Colors.black,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[900],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.kTextFieldBorderSideColor),
    ),
    hintStyle: const TextStyle(color: Colors.white70),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.kAddTodoColor,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: DarkMoodAppColors.kMainItemsColor,
  ),
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF1A1A1F),
    onSurface: Colors.white,
  ),
);
