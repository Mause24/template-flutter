import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'custom_button.dart';

/// Estilos centralizados para el componente CustomButton.
///
/// Este archivo define:
/// - Padding base
/// - BorderRadius base
/// - Colores y bordes según la variante
///
class CustomButtonStyles {
  /// Padding interno por defecto del botón.
  static const basePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  /// Radio por defecto del botón.
  /// Se reutiliza tanto para el contenedor como para el InkWell
  /// para mantener consistencia visual.
  static const baseRadius = BorderRadius.all(Radius.circular(7));

  /// Devuelve el color de fondo del botón según la variante.
  ///
  /// - primary / secondary → colores principales de la app
  /// - disabled → gris atenuado
  /// - outline → transparente (no usa background)
  ///
  static Color background(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.fromKey(AppColorKey.primary);

      case ButtonVariant.secondary:
        return AppColors.fromKey(AppColorKey.secondary);

      case ButtonVariant.disabled:
        return AppColors.fromKey(AppColorKey.greyBlack);

      default:
        return Colors.transparent;
    }
  }

  /// Devuelve la decoración completa del botón según la variante.
  ///
  /// - outline / outlineSecondary → solo borde + radio
  /// - primary / secondary / disabled → color de fondo + radio
  ///
  /// Esta decoración puede ser sobreescrita desde el
  /// CustomButton usando `decorationOverride` si se necesita
  /// un caso visual especial.
  static BoxDecoration? decoration(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.outline:
        return BoxDecoration(
          borderRadius: baseRadius,
          border: Border.all(
            color: AppColors.fromKey(AppColorKey.primary),
            width: 2,
          ),
        );

      case ButtonVariant.outlineSecondary:
        return BoxDecoration(
          borderRadius: baseRadius,
          border: Border.all(
            color: AppColors.fromKey(AppColorKey.secondary),
            width: 2,
          ),
        );

      default:
        return BoxDecoration(
          borderRadius: baseRadius,
          color: background(variant),
        );
    }
  }

  /// Retorna la clave de color del texto según la variante del botón.
  ///
  /// La conversión a `Color` real se hace en el componente `Font`.
  /// Esto mantiene consistencia con el sistema de colores de la app.
  ///
  /// - primary / secondary → texto blanco
  /// - outline → texto color primary
  /// - outlineSecondary → texto color secondary
  /// - disabled → texto blanco atenuado visualmente por la opacidad
  ///
  static AppColorKey textColorKey(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return AppColorKey.white;

      case ButtonVariant.outline:
        return AppColorKey.primary;

      case ButtonVariant.outlineSecondary:
        return AppColorKey.secondary;

      case ButtonVariant.disabled:
        return AppColorKey.white;
    }
  }
}
