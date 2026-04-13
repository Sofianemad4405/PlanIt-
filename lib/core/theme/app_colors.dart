import 'package:flutter/material.dart';
import 'package:planitt/core/adapters/color_model.dart';

class AppColors {
  // Priority colors
  static const Color kUrgentPriorityColor = Color(0xFFFF453A);
  static const Color kHighPriorityColor = Color(0xFFFF9F0A);
  static const Color kMediumPriorityColor = Color(0xFF30D158);
  static const Color kLowPriorityColor = Color(0xFF636366);

  // Accent / Brand
  static const Color kAccent = Color(0xFF6C63FF);
  static const Color kAccentSecondary = Color(0xFF845EF7);
  static const Color kAccentTertiary = Color(0xFFA78BFA);

  // Semantic
  static const Color kRedColor = Color(0xFFFF453A);
  static const Color kGreenColor = Color(0xFF30D158);
  static const Color kOrangeColor = Color(0xFFFF9F0A);
  static const Color kBlueColor = Color(0xFF0A84FF);
  static const Color kWhiteColor = Color(0xFFFFFFFF);

  // Project palette
  static const Color kProjectIconColor1 = Color(0xFF6C63FF);
  static const Color kProjectIconColor2 = Color(0xFF30D158);
  static const Color kProjectIconColor3 = Color(0xFFFF9F0A);
  static const Color kProjectIconColor4 = Color(0xFFFF453A);
  static const Color kProjectIconColor5 = Color(0xFFBF5AF2);
  static const Color kProjectIconColor6 = Color(0xFFFF2D55);
  static const Color kProjectIconColor7 = Color(0xFF32ADE6);
  static const Color kProjectIconColor8 = Color(0xFFFF6B35);
  static const Color kProjectIconColor9 = Color(0xFF636366);
}

class DarkMoodAppColors extends AppColors {
  // Background layers
  static const Color kScaffold = Color(0xFF0A0A0F);
  static const Color kSurface = Color(0xFF13131A);
  static const Color kSurfaceElevated = Color(0xFF1C1C26);
  static const Color kSurfaceContainer = Color(0xFF22222E);
  static const Color kGlassBase = Color(0xFF1A1A24);

  // Navigation
  static const Color kBottomNav = Color(0xFF111118);
  static const Color kFloatingNav = Color(0xFF18181F);

  // Text
  static const Color kTextPrimary = Color(0xFFFFFFFF);
  static const Color kTextSecondary = Color(0xFF8E8E9A);
  static const Color kTextTertiary = Color(0xFF636370);

  // Borders
  static const Color kBorderSubtle = Color(0xFF2C2C3A);
  static const Color kBorderGlass = Color(0xFF3A3A4E);

  // Selected / Active
  static const Color kSelectedItemColor = Color(0xFF6C63FF);
  static const Color kUnSelectedItemColor = Color(0xFF636370);

  // Divider
  static const Color kDivider = Color(0xFF1E1E28);

  // Glass overlay
  static const Color kGlassOverlay = Color(0x1AFFFFFF);
  static const Color kGlassStroke = Color(0x33FFFFFF);

  // Dialog
  static const Color kDialogColor = Color(0xFF13131A);

  static List<ColorModel> kProjectIconColors = [
    ColorModel(AppColors.kProjectIconColor1.toARGB32()),
    ColorModel(AppColors.kProjectIconColor2.toARGB32()),
    ColorModel(AppColors.kProjectIconColor3.toARGB32()),
    ColorModel(AppColors.kProjectIconColor4.toARGB32()),
    ColorModel(AppColors.kProjectIconColor5.toARGB32()),
    ColorModel(AppColors.kProjectIconColor6.toARGB32()),
    ColorModel(AppColors.kProjectIconColor7.toARGB32()),
    ColorModel(AppColors.kProjectIconColor8.toARGB32()),
    ColorModel(AppColors.kProjectIconColor9.toARGB32()),
  ];
}

class LightMoodAppColors extends AppColors {
  static const Color kScaffold = Color(0xFFF2F2F7);
  static const Color kSurface = Color(0xFFFFFFFF);
  static const Color kSurfaceElevated = Color(0xFFFFFFFF);
  static const Color kTextPrimary = Color(0xFF1C1C1E);
  static const Color kTextSecondary = Color(0xFF8E8E93);
  static const Color kSelectedItemColor = Color(0xFF6C63FF);
  static const Color kUnSelectedItemColor = Color(0xFF8E8E93);
  static const Color kBottomNav = Color(0xFFFFFFFF);
  static const Color kBorderSubtle = Color(0xFFE5E5EA);
}
