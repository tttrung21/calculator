import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF17171C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF17171C),
    ),
    primaryColorDark: Colors.white,
    primaryColorLight: Colors.black,
    textTheme: TextTheme(
      bodyLarge: const TextStyle(color: Colors.white, fontSize: 96, fontWeight: FontWeight.w300),
      bodyMedium: TextStyle(
          color: Colors.white.withOpacity(0.4), fontSize: 40, fontWeight: FontWeight.w300),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF4E505F),
    ),
    primaryColor: const Color(0xFF4E505F),
    cardColor: const Color(0xFF2E2F38),
    indicatorColor: const Color(0xFF4B5EFC),
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF1F2F3),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF1F2F3)),
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.white,
    textTheme: TextTheme(
        bodyLarge: const TextStyle(
            color: Colors.black, fontSize: 72, fontWeight: FontWeight.w300, height: 0),
        bodyMedium: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 32,
            fontWeight: FontWeight.w300,
            height: 0)),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFD2D3DA),
    ),
    primaryColor: const Color(0xFFD2D3DA),
    cardColor: const Color(0xFFFFFFFF),
    indicatorColor: const Color(0xFF4B5EFC),
  );
}
