import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageController {
  static void changeLanguage(BuildContext context, Locale locale) {
    context.setLocale(locale);
  }

  static Locale getLocale(BuildContext context) {
    return context.locale;
  }
}
