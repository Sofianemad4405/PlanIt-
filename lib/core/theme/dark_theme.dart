import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planitt/core/theme/app_colors.dart';

ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark(useMaterial3: true);
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
    displayLarge: GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: DarkMoodAppColors.kTextPrimary,
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: DarkMoodAppColors.kTextPrimary,
      letterSpacing: -0.3,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: DarkMoodAppColors.kTextPrimary,
      letterSpacing: -0.2,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: DarkMoodAppColors.kTextSecondary,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: DarkMoodAppColors.kTextSecondary,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: DarkMoodAppColors.kTextPrimary,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: DarkMoodAppColors.kTextSecondary,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: DarkMoodAppColors.kTextTertiary,
    ),
  );

  return base.copyWith(
    brightness: Brightness.dark,
    textTheme: textTheme,
    primaryColor: DarkMoodAppColors.kSelectedItemColor,
    scaffoldBackgroundColor: DarkMoodAppColors.kScaffold,

    colorScheme: const ColorScheme.dark(
      primary: DarkMoodAppColors.kSelectedItemColor,
      primaryContainer: Color(0xFF2D2B5C),
      secondary: AppColors.kAccentSecondary,
      secondaryContainer: Color(0xFF2A2240),
      surface: DarkMoodAppColors.kSurface,
      surfaceContainerHighest: DarkMoodAppColors.kSurfaceContainer,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: DarkMoodAppColors.kTextPrimary,
      onSurfaceVariant: DarkMoodAppColors.kTextSecondary,
      error: AppColors.kRedColor,
      onError: Colors.white,
      outline: DarkMoodAppColors.kBorderSubtle,
      outlineVariant: DarkMoodAppColors.kBorderGlass,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      foregroundColor: DarkMoodAppColors.kTextPrimary,
      centerTitle: false,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: DarkMoodAppColors.kBottomNav,
      selectedItemColor: DarkMoodAppColors.kSelectedItemColor,
      unselectedItemColor: DarkMoodAppColors.kUnSelectedItemColor,
      type: BottomNavigationBarType.fixed,
      enableFeedback: false,
      elevation: 0,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: DarkMoodAppColors.kBottomNav,
      indicatorColor: DarkMoodAppColors.kSelectedItemColor.withValues(alpha: 0.2),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: DarkMoodAppColors.kSelectedItemColor);
        }
        return const IconThemeData(color: DarkMoodAppColors.kUnSelectedItemColor);
      }),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkMoodAppColors.kSelectedItemColor,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: CircleBorder(),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkMoodAppColors.kSurfaceContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: DarkMoodAppColors.kBorderSubtle, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: DarkMoodAppColors.kBorderSubtle, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: DarkMoodAppColors.kSelectedItemColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.kRedColor, width: 1),
      ),
      hintStyle: GoogleFonts.inter(
        color: DarkMoodAppColors.kTextTertiary,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkMoodAppColors.kSelectedItemColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkMoodAppColors.kSelectedItemColor,
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: DarkMoodAppColors.kSurfaceContainer,
      labelStyle: GoogleFonts.inter(color: DarkMoodAppColors.kTextSecondary, fontSize: 12),
      side: const BorderSide(color: DarkMoodAppColors.kBorderSubtle, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    listTileTheme: const ListTileThemeData(
      tileColor: DarkMoodAppColors.kSurfaceElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    cardTheme: CardThemeData(
      color: DarkMoodAppColors.kSurfaceElevated,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: DarkMoodAppColors.kBorderSubtle, width: 1),
      ),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: DarkMoodAppColors.kSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 24,
    ),

    dividerTheme: const DividerThemeData(
      color: DarkMoodAppColors.kDivider,
      thickness: 1,
      space: 1,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: DarkMoodAppColors.kSelectedItemColor,
      unselectedLabelColor: DarkMoodAppColors.kUnSelectedItemColor,
      indicatorColor: DarkMoodAppColors.kSelectedItemColor,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
      unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
      dividerColor: DarkMoodAppColors.kBorderSubtle,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return DarkMoodAppColors.kSelectedItemColor;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: DarkMoodAppColors.kTextSecondary, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return DarkMoodAppColors.kTextSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return DarkMoodAppColors.kSelectedItemColor;
        }
        return DarkMoodAppColors.kSurfaceContainer;
      }),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: DarkMoodAppColors.kSurfaceElevated,
      contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
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
