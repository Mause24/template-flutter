import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Estilos reutilizables para el componente CheckBox.
///
/// Centralizo aquí toda la parte visual.
///
class CheckBoxStyles {
  /// Tamaño estándar del checkbox (ancho/alto).
  /// Esto lo uso para mantener consistencia en toda la app.
  static const double size = 24;

  /// Estilo de la caja cuando el checkbox está SIN marcar.
  ///
  /// - borde de 2px
  /// - radio de 4px (más cuadrado que redondeado)
  /// - si hay error, el borde se pinta en rojo
  ///
  static BoxDecoration box({
    required bool hasError,
    required AppColorKey borderColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        width: 2,
        color: hasError ? AppColors.red : AppColors.fromKey(borderColor),
      ),
    );
  }

  /// Estilo de la caja cuando está marcada.
  ///
  /// Es igual que `box`, pero:
  /// - tiene fondo de color (`backgroundColor`)
  /// - deja espacio para el ícono de check
  ///
  static BoxDecoration checked({
    required bool hasError,
    required AppColorKey borderColor,
    required AppColorKey backgroundColor,
  }) {
    return BoxDecoration(
      color: AppColors.fromKey(backgroundColor),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        width: 2,
        color: hasError ? AppColors.red : AppColors.fromKey(borderColor),
      ),
    );
  }

  /// Estilo del texto del error.
  ///
  /// Lo separo para mantener consistencia visual con otros errores
  /// del sistema (inputs, selects, etc.).
  ///
  static TextStyle errorStyle() {
    return const TextStyle(
      fontSize: 12,
      color: AppColors.red,
      fontFamily: 'Roboto',
    );
  }
}
