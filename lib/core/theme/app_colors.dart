import 'dart:ui';

import 'package:planitt/core/adapters/color_model.dart';

class DarkMoodAppColors {
  static const Color kRedColor = Color(0xFFEF4444); //also for
  static const Color kWhiteColor = Color(0xFFFFFFFF);
  static const Color kDateColor = Color(0xFF9CA3AF);
  static const Color kHintColor = Color(0xFFCCCCCC);
  static const Color kFillColor = Color(0xFF1A1A1F);
  static const Color kSelectedItemColor = Color(
    0xFF4F46E5,
  ); //also for save button
  static const Color kUnSelectedItemColor = Color(0xFF6B7280);
  static const Color kDialogColor = Color(0xFF101115);
  static const Color kScaffoldColor = Color(0xFF101115);

  //project colors
  static const Color kProjectIconColor1 = Color(0xFF4F46E5);
  static const Color kProjectIconColor2 = Color(0xFF10B981);
  static const Color kProjectIconColor3 = Color(0xFFF59E0B);
  static const Color kProjectIconColor4 = Color(0xFFEF4444);
  static const Color kProjectIconColor5 = Color(0xFF8B5CF6);
  static const Color kProjectIconColor6 = Color(0xFFEC4899);
  static const Color kProjectIconColor7 = Color(0xFF06B6D4);
  static const Color kProjectIconColor8 = Color(0xFFF97316);
  static const Color kProjectIconColor9 = Color(0xFF9CA3AF);

  static List<ColorModel> kProjectIconColors = [
    ColorModel(kProjectIconColor1.value),
    ColorModel(kProjectIconColor2.value),
    ColorModel(kProjectIconColor3.value),
    ColorModel(kProjectIconColor4.value),
    ColorModel(kProjectIconColor5.value),
    ColorModel(kProjectIconColor6.value),
    ColorModel(kProjectIconColor7.value),
    ColorModel(kProjectIconColor8.value),
    ColorModel(kProjectIconColor9.value),
  ];

  //task priority colors
  static const Color kHighPriorityColor = Color(0xFFFB923C);
  static const Color kMediumPriorityColor = Color(0xFF60A5FA);
  static const Color kLowPriorityColor = Color(0xFFF9CA3A);
  static const Color kUrgentPriorityColor = Color(0xFFF87171);

  //borderSide colors
  static const Color kTextFieldBorderSideColor = Color(0xFF374151);
}
