import 'package:flutter/material.dart';

/// Claves semánticas de color disponibles en la app.
///
/// Este enum evita usar colores hardcodeados
/// directamente en los widgets.
///
/// En su lugar, siempre se usa una clave semántica
/// que luego se transforma en un Color real
/// mediante `AppColors.fromKey()`.
///
enum AppColorKey {
  // =========================
  // 🌞 LIGHT
  // =========================
  primaryLight,
  primaryHoverLight,
  primarySurfaceLight,
  backgroundLight,
  surfaceLight,
  textPrimaryLight,
  textSecondaryLight,
  textInverseLight,
  borderLight,
  dividerLight,
  successLight,
  warningLight,
  errorLight,
  infoLight,
  // =========================
  // 🌙 DARK
  // =========================
  primaryDark,
  primaryHoverDark,
  primarySurfaceDark,
  backgroundDark,
  surfaceDark,
  textPrimaryDark,
  textSecondaryDark,
  textInverseDark,
  borderDark,
  dividerDark,
  successDark,
  warningDark,
  errorDark,
  infoDark,
  // =========================
  // 🖤 BLACK (AMOLED)
  // =========================
  backgroundBlack,
  surfaceBlack,
  textPrimaryBlack,
  textSecondaryBlack,
  // =========================
  //  BASICS
  // =========================
  black,
  white,
  blackTransparent,
  whiteTransparent,
}

/// Paleta centralizada de colores reales de la aplicación.
///
/// Reglas:
/// - NO usar `Color(...)` directamente en los componentes
/// - SIEMPRE usar `AppColorKey` + `AppColors.fromKey()`
///
/// Esto permite:
/// - cambiar colores globalmente
/// - mantener coherencia visual
/// - separar semántica de implementación
///
class AppColors {
  // =========================
  // 🌞 LIGHT
  // =========================
  static const primaryLight = Color(0xFF20406E);
  static const primaryHoverLight = Color(0xFF2D5587);
  static const primarySurfaceLight = Color.fromARGB(255, 236, 244, 255);

  static const backgroundLight = Color(0xFFF5F7FA);
  static const surfaceLight = Color(0xFFFFFFFF);

  static const textPrimaryLight = Color(0xFF1F2937);
  static const textSecondaryLight = Color(0xFF6B7280);
  static const textInverseLight = Color(0xFFFFFFFF);

  static const borderLight = Color(0xFFE5E7EB);
  static const dividerLight = Color(0xFFD1D5DB);

  static const successLight = Color(0xFF22C55E);
  static const warningLight = Color(0xFFF59E0B);
  static const errorLight = Color(0xFFEF4444);
  static const infoLight = Color(0xFF3B82F6);

  // =========================
  // 🌙 DARK
  // =========================
  static const primaryDark = Color(0xFF2D5587);
  static const primaryHoverDark = Color(0xFF3A6AA3);
  static const primarySurfaceDark = Color(0xFFD0E1F8);

  static const backgroundDark = Color(0xFF0F172A);
  static const surfaceDark = Color(0xFF1E293B);

  static const textPrimaryDark = Color(0xFFF9FAFB);
  static const textSecondaryDark = Color(0xFF9CA3AF);
  static const textInverseDark = Color(0xFFFFFFFF);

  static const borderDark = Color(0xFF334155);
  static const dividerDark = Color(0xFF475569);

  static const successDark = Color(0xFF22C55E);
  static const warningDark = Color(0xFFFBBF24);
  static const errorDark = Color(0xFFF87171);
  static const infoDark = Color(0xFF60A5FA);

  // =========================
  // 🖤 BLACK (AMOLED)
  // =========================
  static const backgroundBlack = Color(0xFF000000);
  static const surfaceBlack = Color(0xFF0A0A0A);

  static const textPrimaryBlack = Color(0xFFFFFFFF);
  static const textSecondaryBlack = Color(0xFF9CA3AF);
  // =========================
  //  BASICS
  // =========================
  static const black = Colors.black;
  static const white = Colors.white;
  static const blackTransparent = Color.fromRGBO(0, 0, 0, 0.5);
  static const whiteTransparent = Color.fromRGBO(255, 255, 255, 0.25);

  static Color fromKey(AppColorKey key) {
    switch (key) {
      case AppColorKey.primaryLight:
        return primaryLight;
      case AppColorKey.primaryHoverLight:
        return primaryHoverLight;
      case AppColorKey.primarySurfaceLight:
        return primarySurfaceLight;
      case AppColorKey.backgroundLight:
        return backgroundLight;
      case AppColorKey.surfaceLight:
        return surfaceLight;
      case AppColorKey.textPrimaryLight:
        return textPrimaryLight;
      case AppColorKey.textSecondaryLight:
        return textSecondaryLight;
      case AppColorKey.textInverseLight:
        return textInverseLight;
      case AppColorKey.borderLight:
        return borderLight;
      case AppColorKey.dividerLight:
        return dividerLight;
      case AppColorKey.successLight:
        return successLight;
      case AppColorKey.warningLight:
        return warningLight;
      case AppColorKey.errorLight:
        return errorLight;
      case AppColorKey.infoLight:
        return infoLight;
      case AppColorKey.primaryDark:
        return primaryDark;
      case AppColorKey.primaryHoverDark:
        return primaryHoverDark;
      case AppColorKey.backgroundDark:
        return primarySurfaceDark;
      case AppColorKey.primarySurfaceDark:
        return backgroundDark;
      case AppColorKey.surfaceDark:
        return surfaceDark;
      case AppColorKey.textPrimaryDark:
        return textPrimaryDark;
      case AppColorKey.textSecondaryDark:
        return textSecondaryDark;
      case AppColorKey.textInverseDark:
        return textInverseDark;
      case AppColorKey.borderDark:
        return borderDark;
      case AppColorKey.dividerDark:
        return dividerDark;
      case AppColorKey.successDark:
        return successDark;
      case AppColorKey.warningDark:
        return warningDark;
      case AppColorKey.errorDark:
        return errorDark;
      case AppColorKey.infoDark:
        return infoDark;
      case AppColorKey.backgroundBlack:
        return backgroundBlack;
      case AppColorKey.surfaceBlack:
        return surfaceBlack;
      case AppColorKey.textPrimaryBlack:
        return textPrimaryBlack;
      case AppColorKey.textSecondaryBlack:
        return textSecondaryBlack;
      case AppColorKey.black:
        return black;
      case AppColorKey.white:
        return white;
      case AppColorKey.blackTransparent:
        return blackTransparent;
      case AppColorKey.whiteTransparent:
        return whiteTransparent;
    }
  }
}
