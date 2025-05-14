import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.borderColor, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPallete.gradient2, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
  );
}
