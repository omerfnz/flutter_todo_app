import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Extension on BuildContext for easy access to localization and theme.
extension BuildContextExtension on BuildContext {
  /// Returns the current locale.
  Locale get locale => EasyLocalization.of(this)!.locale;

  /// Returns the current theme data.
  ThemeData get theme => Theme.of(this);

  /// Returns the current color scheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current text theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Translates the given key using EasyLocalization.
  String tr(String key, {List<String>? args}) => key.tr(args: args);
}
