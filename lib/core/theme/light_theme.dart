import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planitt/core/theme/app_colors.dart';

ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light(useMaterial3: true);
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
    displayLarge: GoogleFonts.inter(fontSize: 34, fontWeight: FontWeight.w700, color: LightMoodAppColors.kTextPrimary, letterSpacing: -0.5),
    headlineLarge: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: LightMoodAppColors.kTextPrimary),
    headlineMedium: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: LightMoodAppColors.kTextPrimary),
    titleLarge: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, color: LightMoodAppColors.kTextPrimary),
    titleMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: LightMoodAppColors.kTextPrimary),
    bodyLarge: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w400, color: LightMoodAppColors.kTextPrimary),
    bodyMedium: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: LightMoodAppColors.kTextPrimary),
    bodySmall: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: LightMoodAppColors.kTextSecondary),
    labelMedium: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: LightMoodAppColors.kTextSecondary),
  );

  return base.copyWith(
    brightness: Brightness.light,
    textTheme: textTheme,
    primaryColor: LightMoodAppColors.kSelectedItemColor,
    scaffoldBackgroundColor: LightMoodAppColors.kScaffold,
    colorScheme: const ColorScheme.light(
      primary: LightMoodAppColors.kSelectedItemColor,
      surface: LightMoodAppColors.kSurface,
      onSurface: LightMoodAppColors.kTextPrimary,
      onSurfaceVariant: LightMoodAppColors.kTextSecondary,
      error: AppColors.kRedColor,
      outline: LightMoodAppColors.kBorderSubtle,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: LightMoodAppColors.kTextPrimary,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LightMoodAppColors.kBottomNav,
      selectedItemColor: LightMoodAppColors.kSelectedItemColor,
      unselectedItemColor: LightMoodAppColors.kUnSelectedItemColor,
      type: BottomNavigationBarType.fixed,
      enableFeedback: false,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F2F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LightMoodAppColors.kBorderSubtle, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LightMoodAppColors.kBorderSubtle, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: LightMoodAppColors.kSelectedItemColor, width: 1.5),
      ),
      hintStyle: GoogleFonts.inter(color: LightMoodAppColors.kUnSelectedItemColor, fontSize: 15),
    ),
    cardTheme: CardThemeData(
      color: LightMoodAppColors.kSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: LightMoodAppColors.kBorderSubtle, width: 1),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: LightMoodAppColors.kSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: LightMoodAppColors.kSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 24,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightMoodAppColors.kSelectedItemColor,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: CircleBorder(),
    ),
    dividerTheme: const DividerThemeData(color: LightMoodAppColors.kBorderSubtle, thickness: 1),
    tabBarTheme: TabBarThemeData(
      labelColor: LightMoodAppColors.kSelectedItemColor,
      unselectedLabelColor: LightMoodAppColors.kUnSelectedItemColor,
      indicatorColor: LightMoodAppColors.kSelectedItemColor,
      labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
      unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
      dividerColor: LightMoodAppColors.kBorderSubtle,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) =>
        s.contains(WidgetState.selected) ? LightMoodAppColors.kSelectedItemColor : Colors.transparent),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: LightMoodAppColors.kUnSelectedItemColor, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
