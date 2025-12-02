import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';

/// Utilidades para construir estilos tipográficos.
///
/// Centralizo aquí:
/// - tamaños
/// - variantes de fuente
/// - mapeo de familias
///
class FontStyles {
  /// Escala tipográfica del sistema.
  ///
  /// Uso strings para facilitar lectura
  /// y consistencia en toda la app.
  ///
  static const Map<String, double> sizes = {
    "xs": 11,
    "sm": 14,
    "base": 16,
    "lg": 18,
    "xl": 20,
    "2xl": 24,
    "3xl": 28,
  };

  /// Construye un TextStyle a partir del sistema tipográfico.
  ///
  /// Combina:
  /// - tamaño
  /// - familia de fuente
  /// - color
  /// - estilos extra
  ///
  static TextStyle build({
    required String size,
    required String fontVariant,
    AppColorKey? color,
    Color? customColor,
    TextStyle? extraStyle,
  }) {
    final double fontSize = sizes[size] ?? sizes["base"]!;

    // Prioridad: customColor > AppColorKey
    final Color resolvedColor =
        customColor ?? AppColors.fromKey(color ?? AppColorKey.black);

    final String resolvedFamily = _resolveFontFamily(fontVariant);

    return TextStyle(
      fontSize: fontSize,
      fontFamily: resolvedFamily,
      color: resolvedColor,
    ).merge(extraStyle);
  }

  // --------------------------------------------------
  // Resolución de familia tipográfica
  // --------------------------------------------------

  /// Determina la familia de fuente según la variante.
  static String _resolveFontFamily(String variant) {
    switch (variant) {
      case "RobotoBlack":
      case "RobotoBlackItalic":
      case "RobotoBold":
      case "RobotoBoldItalic":
      case "RobotoItalic":
      case "RobotoLight":
      case "RobotoMedium":
      case "RobotoRegular":
      case "RobotoThin":
        return AppTypography.defaultFamily;

      case "RobotoCondensedBold":
        return AppTypography.condensedFamily;

      default:
        // Fallback seguro
        return AppTypography.defaultFamily;
    }
  }
}
