import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF7B61FF); // Neon Purple
  static const Color _secondaryColor = Color(0xFF00E5FF); // Neon Cyan
  static const Color _backgroundColor = Color(0xFF0A0A0A); // Almost Black
  static const Color _surfaceColor = Color(0xFF1E1E1E); // Dark Grey
  static const Color _errorColor = Color(0xFFCF6679);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: _surfaceColor,
        surfaceContainerHighest: _backgroundColor, // Background
        error: _errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: _primaryColor.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      /* cardTheme: CardTheme(
        color: _surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
      ), */
      iconTheme: const IconThemeData(
        color: _primaryColor,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withOpacity(0.1),
        thickness: 1,
      ),
    );
  }
}
