// lib/utils/theme.dart
import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);
