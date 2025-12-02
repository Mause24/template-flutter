import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'select_field.dart';

/// Estilos del SelectField.
///
/// Soporta:
/// - variantes visuales
/// - modo invertido (fondos oscuros)
///
class SelectFieldStyles {
  final SelectFieldVariant variant;

  /// Indica si el select se renderiza sobre fondo oscuro.
  final bool inverted;

  SelectFieldStyles._(this.variant, {this.inverted = false});

  /// Factory para crear estilos según variante.
  static SelectFieldStyles of(SelectFieldVariant v, {bool inverted = false}) =>
      SelectFieldStyles._(v, inverted: inverted);

  /// Altura mínima del campo.
  double get fieldHeight => variant == SelectFieldVariant.primary ? 42 : 40;

  /// Padding interno del campo.
  EdgeInsets get fieldPadding =>
      variant == SelectFieldVariant.primary
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
          : const EdgeInsets.symmetric(horizontal: 0, vertical: 0);

  /// Radio del campo.
  BorderRadius get fieldRadius => BorderRadius.circular(6);

  /// Decoración del campo.
  BoxDecoration get fieldDecoration {
    if (inverted) {
      return BoxDecoration(
        color: AppColors.fromKey(AppColorKey.primary),
        borderRadius: fieldRadius,
        border: Border.all(
          color: AppColors.fromKey(AppColorKey.white),
          width: 1.5,
        ),
      );
    }

    switch (variant) {
      case SelectFieldVariant.primary:
        return BoxDecoration(
          color: AppColors.fromKey(AppColorKey.whiteTransparent),
          borderRadius: fieldRadius,
          border: Border.all(
            color: AppColors.fromKey(AppColorKey.grayInput),
            width: 2,
          ),
        );

      case SelectFieldVariant.secondary:
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

  /// Estilo del texto seleccionado / placeholder.
  TextStyle valueTextStyle(bool filled) => TextStyle(
    color:
        inverted
            ? AppColors.fromKey(AppColorKey.white)
            : (filled ? AppColors.fromKey(AppColorKey.black) : Colors.grey),
    fontSize: 15,
  );

  /// Estilo del título.
  TextStyle get titleTextStyle => TextStyle(
    color: AppColors.fromKey(AppColorKey.primary),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilos del dropdown.
  BorderRadius get dropdownRadius => BorderRadius.circular(8);

  BoxDecoration get dropdownDecoration => BoxDecoration(
    color: AppColors.fromKey(AppColorKey.white),
    borderRadius: dropdownRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  /// Padding interno de cada item.
  EdgeInsets get itemPadding =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 12);

  /// Estilo del texto de cada item del dropdown.
  TextStyle get itemTextStyle =>
      const TextStyle(fontSize: 15, color: Colors.black87);

  /// Estilo del mensaje de error.
  TextStyle get errorTextStyle =>
      TextStyle(color: AppColors.fromKey(AppColorKey.red), fontSize: 12.5);
}
