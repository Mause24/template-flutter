import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Estilos del componente PhoneField.
///
/// Centraliza:
/// - estilos del título
/// - paddings del dropdown
///
class PhoneFieldStyles {
  /// Estilo del título del campo.
  ///
  /// Mantiene consistencia con DateField
  /// y otros inputs del sistema.
  ///
  TextStyle get titleTextStyle => TextStyle(
    color: AppColors.fromKey(AppColorKey.primary),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Padding interno de cada item del selector.
  ///
  /// Asegura buena separación visual
  /// entre bandera, texto y extensión.
  ///
  EdgeInsets get itemPadding =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
}
