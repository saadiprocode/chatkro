import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Color(0xFF121212), // Dark gray/black background
    primary: Color(0xFF075E54), // WhatsApp green
    secondary: Color(0xFF128C7E), // WhatsApp green variant
    tertiary: Color(0xFF25D366), // Lighter green for accents
    inversePrimary: Colors.white, // Text color for dark mode
  ),
  scaffoldBackgroundColor: Color(0xFF121212),
  appBarTheme: AppBarTheme(
    color: Color(0xFF075E54),
  ),
);
