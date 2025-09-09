import 'package:flutter/material.dart';
import 'package:planitt/core/adapters/color_model.dart';

class AppColors {
  // ثابتة ومش مرتبطة بالثيم
  static const Color kHighPriorityColor = Color.fromARGB(255, 0, 255, 0);
  static const Color kMediumPriorityColor = Color(0xFF1D3DA8);
  static const Color kLowPriorityColor = Color(0xFF353E4E);
  static const Color kUrgentPriorityColor = Color(0xFF931A1A);

  static const Color kAddTodoColor = Color(0xFF1D3DA8);
  static const Color kRedColor = Color(0xFFEF4444);
  static const Color kWhiteColor = Color(0xFFFFFFFF);
  static const Color kDateColor = Color(0xFF9CA3AF);
  static const Color kHintColor = Color(0xFFCCCCCC);

  // borderSide
  static const Color kTextFieldBorderSideColor = Color(0xFF374151);

  // project icon colors (ثابتة تنفع للاتنين)
  static const Color kProjectIconColor1 = Color(0xFF4F46E5);
  static const Color kProjectIconColor2 = Color(0xFF10B981);
  static const Color kProjectIconColor3 = Color(0xFFF59E0B);
  static const Color kProjectIconColor4 = Color(0xFFEF4444);
  static const Color kProjectIconColor5 = Color(0xFF8B5CF6);
  static const Color kProjectIconColor6 = Color(0xFFEC4899);
  static const Color kProjectIconColor7 = Color(0xFF06B6D4);
  static const Color kProjectIconColor8 = Color(0xFFF97316);
  static const Color kProjectIconColor9 = Color(0xFF9CA3AF);
}

class LightMoodAppColors extends AppColors {
  static const Color kBackground = Color.fromARGB(255, 232, 232, 232);
  static const Color kAppBar = Color.fromARGB(255, 232, 232, 232);
  static const Color kBottomNav = Colors.white;
  static const Color kSelectedItemColor = Colors.black;
  static const Color kUnMainItemsColor = Colors.white;
  static const Color kUnSelectedItemColor = Colors.grey;
  static const Color kSurfaceColor = Color.fromARGB(255, 241, 241, 241);
}

class DarkMoodAppColors extends AppColors {
  static const Color kFillColor = Color(0xFF1A1A1F);
  static const Color kSelectedItemColor = Color(0xFF4F46E5); // also save button
  static const Color kUnSelectedItemColor = Color(0xFF6B7280);
  static const Color kDialogColor = Color(0xFF101115);
  static const Color kScaffoldColor = Color(0XFF111215);
  static const Color kButtomNavBar = Color(0XFF0B0B0C);
  static const Color kMainItemsColor = Color.fromARGB(255, 37, 37, 37);

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
