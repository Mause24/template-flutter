import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'separator_styles.dart';

/// Variantes disponibles del Separator.
///
/// - thin: línea fina (1px)
/// - thick: línea gruesa
/// - faded: línea con opacidad
/// - custom: configuración totalmente personalizada
///
enum SeparatorVariant { thin, thick, faded, custom }

/// Componente Separator.
///
/// Se usa para:
/// - separar secciones
/// - dividir contenido visualmente
/// - agregar espacios con línea horizontal o vertical
///
/// Ventajas:
/// - un solo componente para todos los separadores
/// - consistente con el sistema de colores
/// - soporta orientación horizontal y vertical
///
class Separator extends StatelessWidget {
  /// Variante visual del separador.
  final SeparatorVariant variant;

  /// Color del separador usando AppColorKey.
  final AppColorKey color;

  /// Indica si el separador es vertical.
  ///
  /// false → horizontal
  /// true  → vertical
  ///
  final bool vertical;

  /// Grosor de la línea (solo para custom).
  final double thickness;

  /// Espaciado alrededor de la línea.
  final double space;

  /// Altura del separador vertical (custom).
  final double? height;

  /// Ancho del separador horizontal (custom).
  final double? width;

  /// Opacidad del separador.
  final double opacity;

  const Separator({
    super.key,
    this.variant = SeparatorVariant.custom,
    this.color = AppColorKey.gray,
    this.vertical = false,
    this.thickness = 8,
    this.space = 5,
    this.height,
    this.width,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final styles = SeparatorStyles.base;

    switch (variant) {
      case SeparatorVariant.thin:
        return styles.thin(color: color, vertical: vertical, space: space);

      case SeparatorVariant.thick:
        return styles.thick(color: color, vertical: vertical, space: space);

      case SeparatorVariant.faded:
        return styles.faded(color: color, vertical: vertical, opacity: opacity);

      case SeparatorVariant.custom:
        return _buildCustom(AppColors.fromKey(color));
    }
  }

  /// Construcción del separador custom.
  ///
  /// Permite controlar directamente:
  /// - orientación
  /// - grosor
  /// - tamaño
  /// - opacidad
  ///
  Widget _buildCustom(Color resolved) {
    final widget =
        vertical
            ? Container(
              width: thickness,
              height: height ?? 40,
              margin: EdgeInsets.symmetric(horizontal: space),
              color: resolved,
            )
            : Container(
              height: thickness,
              width: width ?? double.infinity,
              margin: EdgeInsets.symmetric(vertical: space),
              color: resolved,
            );

    // Aplica opacidad solo si es necesario
    return opacity == 1.0 ? widget : Opacity(opacity: opacity, child: widget);
  }
}
