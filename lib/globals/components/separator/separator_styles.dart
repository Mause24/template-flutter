import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'separator.dart';

/// Estilos y helpers del Separator.
///
/// Centraliza variantes comunes para evitar
/// repetir configuración en toda la app.
///
class SeparatorStyles {
  /// Instancia base reutilizable.
  static final base = _BaseSeparatorStyles();

  /// Espaciado por defecto (referencial).
  static const EdgeInsets defaultSpacing = EdgeInsets.symmetric(vertical: 8);
}

/// Estilos concretos del Separator.
///
/// Cada método retorna un `Separator`
/// ya configurado con valores estándar.
///
class _BaseSeparatorStyles {
  /// Separador delgado.
  ///
  /// Útil para:
  /// - listas
  /// - divisiones suaves
  ///
  Widget thin({
    AppColorKey color = AppColorKey.gray,
    bool vertical = false,
    double space = 8,
  }) {
    return Separator(
      variant: SeparatorVariant.custom,
      vertical: vertical,
      color: color,
      thickness: 1,
      space: space,
    );
  }

  /// Separador grueso.
  ///
  /// Útil para:
  /// - separar secciones grandes
  /// - jerarquía visual fuerte
  ///
  Widget thick({
    AppColorKey color = AppColorKey.black,
    bool vertical = false,
    double space = 12,
  }) {
    return Separator(
      variant: SeparatorVariant.custom,
      vertical: vertical,
      color: color,
      thickness: 4,
      space: space,
    );
  }

  /// Separador con opacidad.
  ///
  /// Útil cuando se necesita una
  /// separación visual sutil.
  ///
  Widget faded({
    AppColorKey color = AppColorKey.black,
    bool vertical = false,
    double opacity = 0.3,
  }) {
    return Separator(
      variant: SeparatorVariant.custom,
      vertical: vertical,
      color: color,
      thickness: 2,
      space: 8,
      opacity: opacity,
    );
  }
}
