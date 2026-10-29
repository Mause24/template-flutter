import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// Estilos reutilizables del DateField.
///
/// Centralizo aquí:
/// - paddings
/// - bordes
/// - colores
/// - tipografías
///
class DateFieldStyles {
  /// Padding interno del campo.
  EdgeInsets get fieldPadding =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 12);

  /// Radio de borde del campo.
  BorderRadius get fieldRadius => BorderRadius.circular(6);

  /// Decoración del campo.
  ///
  /// - borde primario por defecto
  /// - borde rojo cuando hay error
  ///
  BoxDecoration fieldDecoration(bool hasError) => BoxDecoration(
    borderRadius: fieldRadius,
    border: Border.all(
      color:
          hasError
              ? AppColors.fromKey(AppColorKey.errorLight)
              : AppColors.fromKey(AppColorKey.primaryLight),
      width: 1,
    ),
  );

  /// Estilo del texto del valor o placeholder.
  ///
  /// - gris cuando está vacío
  /// - negro cuando está lleno
  /// - rojo si hay error
  ///
  TextStyle valueTextStyle({required bool filled, required bool hasError}) =>
      TextStyle(
        color:
            hasError
                ? AppColors.fromKey(AppColorKey.errorLight)
                : filled
                ? AppColors.fromKey(AppColorKey.black)
                : AppColors.fromKey(AppColorKey.borderDark),
        fontSize: 15,
      );

  /// Estilo del título del campo.
  TextStyle get titleTextStyle => TextStyle(
    color: AppColors.fromKey(AppColorKey.primaryLight),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo del mensaje de error.
  ///
  /// Coincide visualmente con errores
  /// de inputs, selects y otros fields.
  ///
  TextStyle get errorTextStyle =>
      TextStyle(color: AppColors.fromKey(AppColorKey.errorLight), fontSize: 12);
}
