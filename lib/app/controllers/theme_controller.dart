import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitt/core/services/prefs.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final saved = await PreferencesService.getString("theme");
    if (saved == "dark") {
      emit(ThemeMode.dark);
    } else if (saved == "light") {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      PreferencesService.saveString("theme", "dark");
    } else {
      emit(ThemeMode.light);
      PreferencesService.saveString("theme", "light");
    }
  }

  ThemeMode get theme => state;

  void setTheme(ThemeMode mode) {
    emit(mode);
    PreferencesService.saveString("theme", mode.toString());
  }
}
