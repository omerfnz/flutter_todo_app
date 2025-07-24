import 'package:flutter/material.dart';

/// Provides the Material 3 dark theme configuration for the app.
class ThemeInitialize {
  /// Returns the dark theme configuration for the app.
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme:
            AppBarTheme(backgroundColor: Colors.grey[900], elevation: 0),
        cardTheme: CardTheme(
          color: Colors.grey[800],
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      );
}
