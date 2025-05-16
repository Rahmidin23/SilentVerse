 // lib/blocs/theme/theme_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/shared_prefs.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark) {
    _loadTheme();
  }

  void _loadTheme() async {
    final isDark = await SharedPrefs.getThemeMode();
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() async {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
      await SharedPrefs.saveThemeMode(false);
    } else {
      emit(ThemeMode.dark);
      await SharedPrefs.saveThemeMode(true);
    }
  }
}
