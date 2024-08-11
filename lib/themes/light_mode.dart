import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white, // WhatsApp light background
    primary: Color(0xFF075E54), // WhatsApp green
    secondary: Color(0xFF25D366), // Lighter green for accents
    tertiary: Colors.grey.shade100, // Light gray for backgrounds
    inversePrimary: Colors.black, // Text color for light mode
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Color(0xFF075E54),
  ),
);
