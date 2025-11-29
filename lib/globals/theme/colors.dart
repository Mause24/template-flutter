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
  primary,
  secondary,

  white,
  black,
  gray,

  blackTransparent,
  whiteTransparent,

  highlightGrey,
  darkGray,
  greyBlack,

  colorTitle,
  grayInput,
  red,

  // ===== Colores semánticos (Message, alerts, estados) =====
  success,
  info,
  warning,
  error,
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
  // ===== Base =====
  static const primary = Color(0xFF166394);
  static const secondary = Color(0xFF20B4FC);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const gray = Color(0xFFCCCCCC);

  // ===== Transparencias =====
  static const blackTransparent = Color.fromRGBO(0, 0, 0, 0.5);
  static const whiteTransparent = Color.fromRGBO(255, 255, 255, 0.25);

  // ===== Grises empleados en UI =====
  static const highlightGrey = Color(0xFFFDFDFD);
  static const darkGray = Colors.grey;
  static const greyBlack = Color.fromRGBO(175, 175, 175, 1);

  static const colorTitle = Color(0xFF2F2F2F);
  static const grayInput = Color(0xFFE6E6E6);

  // ===== Estados =====
  static const red = Colors.red;

  static const success = Color(0xFF2ECC71); // éxito
  static const info = Color(0xFF3498DB); // información
  static const warning = Color(0xFFF1C40F); // advertencia
  static const error = Color(0xFFE74C3C); // error

  /// Conversor central:
  /// Transforma una clave semántica (`AppColorKey`)
  /// en el `Color` real usado por Flutter.
  ///
  static Color fromKey(AppColorKey key) {
    switch (key) {
      case AppColorKey.primary:
        return primary;
      case AppColorKey.secondary:
        return secondary;
      case AppColorKey.white:
        return white;
      case AppColorKey.black:
        return black;
      case AppColorKey.gray:
        return gray;
      case AppColorKey.blackTransparent:
        return blackTransparent;
      case AppColorKey.whiteTransparent:
        return whiteTransparent;
      case AppColorKey.highlightGrey:
        return highlightGrey;
      case AppColorKey.darkGray:
        return darkGray;
      case AppColorKey.greyBlack:
        return greyBlack;
      case AppColorKey.colorTitle:
        return colorTitle;
      case AppColorKey.grayInput:
        return grayInput;
      case AppColorKey.red:
        return red;
      case AppColorKey.success:
        return success;
      case AppColorKey.info:
        return info;
      case AppColorKey.warning:
        return warning;
      case AppColorKey.error:
        return error;
    }
  }
}
