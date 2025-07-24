import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/constants/app_constants.dart';

/// Handles localization initialization and configuration.
class LocalizationInitialize {
  /// Initializes EasyLocalization with supported locales and paths.
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Returns the supported locales for the application.
  static List<Locale> get supportedLocales => const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ];

  /// Returns the fallback locale.
  static Locale get fallbackLocale => const Locale('en', 'US');

  /// Returns the path to translation assets.
  static String get translationsPath => AppConstants.translationsPath;
}
