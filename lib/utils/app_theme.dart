import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPurple = Color(0xFFD1C4E9);
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        titleTextStyle: TextStyle(color:lightPurple, fontSize: 20), // Light purple for the title
        iconTheme: IconThemeData(color: lightPurple), // Light purple for icons

      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // Button background color
          foregroundColor: Colors.white, // Button text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.grey[900]!, // Dark grey background
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800]!, // Dark grey app bar
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Colors.grey[800]!, // Dark grey card color
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[600]!), // Dark grey border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 2), // Light grey focused border
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, // Purple button background color
          foregroundColor: Colors.white, // Button text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
