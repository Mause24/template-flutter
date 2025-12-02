import 'package:flutter/material.dart';

/// Sistema tipográfico de la aplicación.
///
/// Centraliza:
/// - familias de fuentes
/// - tamaños
/// - pesos
///
/// Se aplica globalmente desde el ThemeData.
///
class AppTypography {
  /// Familia por defecto.
  static const defaultFamily = 'Roboto';

  /// Familia condensada (casos específicos).
  static const condensedFamily = 'RobotoCondensed';

  /// TextTheme base de la aplicación.
  ///
  /// Define jerarquías tipográficas estándar:
  /// - display
  /// - headlines
  /// - titles
  /// - body
  ///
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w700),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ).apply(fontFamily: defaultFamily);
}
