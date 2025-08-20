import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:planitt/core/services/prefs.dart';
import 'package:planitt/core/theme/dark_theme.dart';
import 'package:planitt/core/theme/light_theme.dart';
import 'package:planitt/l10n/l10n.dart';
import 'package:planitt/root/root.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  final PreferencesService _prefs = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final langCode = await _prefs.getLanguage() ?? 'en';
    setState(() {
      _locale = Locale(langCode);
    });
  }

  Future<void> _toggleLocale() async {
    log("saving language");
    final newLocale = _locale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');

    // First save the language
    _prefs.saveLanguage(newLocale.languageCode);
    log("saved language ${newLocale.languageCode}");

    // Then update the UI
    if (mounted) {
      setState(() {
        _locale = newLocale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,

      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      home: Root(),
    );
  }
}
