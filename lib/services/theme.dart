import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
  ),
  textTheme: commonTheme.textTheme,
  checkboxTheme: commonTheme.checkboxTheme,
  scaffoldBackgroundColor: commonTheme.scaffoldBackgroundColor,
  primaryColor: commonTheme.primaryColor,
  colorScheme: commonTheme.colorScheme.copyWith(
    primaryVariant: const Color(0xFF0043A1),
    secondaryVariant: const Color(0xFFCA2B4E),
  ),
);
final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Colors.black,
  textTheme: commonTheme.textTheme,
  primaryColor: commonTheme.primaryColor,
  colorScheme: commonTheme.colorScheme.copyWith(
    surface: Colors.black38,
    brightness: Brightness.dark,
    onError: Colors.black38,
    background: Colors.black38,
    onBackground: Colors.black38,
    primaryVariant: const Color(0xFF0043A1),
    secondaryVariant: const Color(0xFFCA2B4E),
  ),
  checkboxTheme: commonTheme.checkboxTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
);

final ThemeData commonTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: const Color(0xFF0055CC),
    secondary: const Color(0xFFF03D63),
    secondaryVariant: const Color(0xFFF03D63),
    onBackground: Colors.white,
    error: const Color(0xFFF03D63),
    onSecondary: const Color(0xFF4BD37B),
    onSurface: const Color(0xFF014BB3),
    surface: Colors.white,
    brightness: Brightness.light,
    onError: Colors.white,
    background: Colors.white,
    onPrimary: const Color(0xFF9EA6BE),
    primaryVariant: const Color(0xFF0251BF),
  ),
  primaryColor: const Color(0xFF0055CC),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: Get.locale == Locale('en') ? 'Poppin' : 'Noor',
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color>(const Color(0xFFC5CEE0)),
  ),
);
