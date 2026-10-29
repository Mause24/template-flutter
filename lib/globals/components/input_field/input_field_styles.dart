import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'input_field.dart';

/// Estilos del componente InputField.
///
/// Centralizo aquí:
/// - contenedores
/// - tipografías
/// - paddings
///
class InputFieldStyles {
  // ================== Container ==================

  /// Decoración del contenedor según la variante.
  ///
  /// - primary: caja completa con fondo y borde
  /// - secondary: solo línea inferior
  ///
  static BoxDecoration container(InputFieldVariant variant) {
    switch (variant) {
      case InputFieldVariant.primary:
        return BoxDecoration(
          color: AppColors.fromKey(AppColorKey.primarySurfaceLight),
          borderRadius: BorderRadius.circular(7),
        );

      case InputFieldVariant.secondary:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.fromKey(AppColorKey.primaryLight),
              width: 1,
            ),
          ),
        );
    }
  }

  // ================== Field Text ==================

  /// Estilo del texto del campo según la variante.
  static TextStyle field(InputFieldVariant variant) {
    switch (variant) {
      case InputFieldVariant.primary:
        return TextStyle(color: AppColors.black, fontSize: 14);

      case InputFieldVariant.secondary:
        return TextStyle(color: AppColors.black, fontSize: 16);
    }
  }

  // ================== Padding ==================

  /// Padding del ícono izquierdo.
  static EdgeInsets leftPadding(InputFieldVariant variant) {
    return variant == InputFieldVariant.primary
        ? const EdgeInsets.only(left: 8, right: 4)
        : const EdgeInsets.only(right: 8);
  }

  /// Padding del ícono derecho.
  static EdgeInsets rightPadding(InputFieldVariant variant) {
    return variant == InputFieldVariant.primary
        ? const EdgeInsets.only(right: 8, left: 4)
        : const EdgeInsets.only(left: 8);
  }
}
