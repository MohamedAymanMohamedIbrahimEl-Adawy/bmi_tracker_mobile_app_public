import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF07167),
      primary: const Color(0xFFF07167),
      secondary: const Color(0xFFFED9B7),
      brightness: Brightness.light,
    ),
    cardColor: Colors.grey,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
      iconTheme: IconThemeData(
        color: Color(0xFFFED9B7),
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
    fontFamily: 'Montserrat',
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF07167),
      primary: const Color(0xFFF07167),
      secondary: const Color(0xFFFED9B7),
      brightness: Brightness.dark,
    ),
    cardColor: const Color(0xFF4e4e5a),
    scaffoldBackgroundColor: const Color(0xFF232331),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1f1f2c),
      iconTheme: IconThemeData(
        color: Color(0xFFFED9B7),
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
    fontFamily: 'Montserrat',
  );

  static ThemeData getTheme(bool isDark) {
    return isDark ? _darkTheme : _lightTheme;
  }
}
