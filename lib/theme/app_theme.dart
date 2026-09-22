import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Palette
  static const Color navyDark = Color(0xFF0B1948);
  static const Color navyDeep = Color(0xFF000213);
  static const Color primaryBlue = Color(0xFF2F55C7);
  static const Color accentBlue = Color(0xFF688AFE);
  static const Color accentCyan = Color(0xFF89F5E7);
  static const Color canvasLight = Color(0xFFF8F9FF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF0B1C30);
  static const Color canvasDark = Color(0xFF020617);
  static const Color surfaceDark = Color(0xFF0F172A);
  static const Color textDark = Color(0xFFF8FAFC);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: canvasLight,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: navyDark,
      surface: surfaceLight,
      onSurface: textLight,
      tertiary: accentCyan,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: textLight,
      displayColor: textLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textLight),
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEFF4FF)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: canvasDark,
    primaryColor: accentBlue,
    colorScheme: const ColorScheme.dark(
      primary: accentBlue,
      secondary: Color(0xFF384474),
      surface: surfaceDark,
      onSurface: textDark,
      tertiary: accentCyan,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: textDark,
      displayColor: textDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textDark),
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF1E293B)),
      ),
    ),
  );
}
