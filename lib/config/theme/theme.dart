import 'package:flutter/material.dart';
import 'package:muzzone/config/config.dart';

class MuzzoneTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    cardColor: AppColors.greyColor,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    secondaryHeaderColor: Colors.black,
    splashColor: AppColors.primaryColor,
    brightness: Brightness.light,
    dialogBackgroundColor: Colors.white,
    disabledColor: AppColors.greyColor,
    textTheme: const TextTheme(
      titleMedium: TextStyle(),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: AppColors.primaryColor),
      labelMedium: TextStyle(color: AppColors.greyColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    secondaryHeaderColor: Colors.white,
    cardColor: Colors.white,
    splashColor: Colors.white,
    brightness: Brightness.dark,
    dialogBackgroundColor: AppColors.greyBackgroundColor,
    disabledColor: AppColors.greyBackgroundColor,
    textTheme: const TextTheme(
      titleMedium: TextStyle(),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
    ),
  );
}
