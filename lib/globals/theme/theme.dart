import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

/// Construye el ThemeData base de la aplicación.
///
/// Centraliza:
/// - esquema de colores
/// - tipografía
/// - estilos por defecto de inputs
///
/// Este theme se inyecta en `MaterialApp`.
///
class AppTheme {
  // 🌞 LIGHT
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryLight,
        secondary: AppColors.primaryDark,
        surface: AppColors.surfaceLight,
        error: AppColors.errorLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryLight,
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: AppTypography.defaultFamily,
    );
  }

  // 🌙 DARK
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        secondary: AppColors.surfaceDark,
        surface: AppColors.surfaceDark,
        error: AppColors.errorDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryDark,
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: AppColors.backgroundDark,

      fontFamily: AppTypography.defaultFamily,
    );
  }

  // 🖤 BLACK (AMOLED)
  static ThemeData black() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        secondary: AppColors.surfaceDark,
        surface: AppColors.surfaceBlack,
        error: AppColors.errorDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),

      scaffoldBackgroundColor: AppColors.backgroundBlack,

      fontFamily: AppTypography.defaultFamily,
    );
  }
}
