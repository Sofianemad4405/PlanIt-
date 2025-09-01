import 'package:flutter/material.dart';
import 'package:planitt/core/theme/dark_theme.dart';
import 'package:planitt/core/theme/light_theme.dart';

class AppTheme {
  static ThemeData dark(BuildContext context) => darkTheme(context);
  static ThemeData light(BuildContext context) => lightTheme(context);
}
