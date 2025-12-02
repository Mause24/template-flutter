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
          color: AppColors.fromKey(AppColorKey.highlightGrey),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: AppColors.fromKey(AppColorKey.grayInput),
            width: 2,
          ),
        );

      case InputFieldVariant.secondary:
        return BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.fromKey(AppColorKey.primary),
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
        return TextStyle(
          fontFamily: "RobotoRegular",
          color: AppColors.fromKey(AppColorKey.black),
          fontSize: 14,
        );

      case InputFieldVariant.secondary:
        return TextStyle(
          fontFamily: "RobotoRegular",
          color: AppColors.fromKey(AppColorKey.black),
          fontSize: 16,
        );
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
