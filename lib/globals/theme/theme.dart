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
ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,

    // ===== Esquema de colores =====
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.white,
      onSurface: AppColors.colorTitle,
    ),

    // Fondo general de la app
    scaffoldBackgroundColor: AppColors.white,

    // Tipografía global
    textTheme: AppTypography.textTheme,

    // ===== Inputs por defecto =====
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grayInput,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      hintStyle: TextStyle(color: AppColors.greyBlack),
    ),
  );
}
