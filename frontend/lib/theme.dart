import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CineVibeTheme {
  static const Color background = Color(0xFF080808);
  static const Color accent = Color(0xFFFF9F1C);
  static const Color spotifyGreen = Color(0xFF1DB954);
  static const Color geminiBlue = Color(0xFF4285F4);
  static const Color surface = Color(0xFF1A1A1A);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: accent,
    colorScheme: ColorScheme.dark(
      primary: accent,
      secondary: geminiBlue,
      surface: surface,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      titleLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.1,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.white70,
        letterSpacing: 0.5,
      ),
    ),
  );
}
