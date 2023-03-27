import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
        ),
      );
}

class AppShadow {
  static final primaryShadow = [
    BoxShadow(
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Colors.black.withOpacity(0.12),
    ),
  ];
}

class AppColors {
  static const primaryColor = Color(0xFFD281B5);
  static const blackColor = Color(0xFF282D53);
}
