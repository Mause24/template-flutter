import 'package:flutter/material.dart';
import 'package:template_flutter/globals/components/font/font.dart';

import '../../theme/colors.dart';
import 'separator_styles.dart';

enum SeparatorVariant { thin, thick, faded, custom }

class Separator extends StatelessWidget {
  final SeparatorVariant variant;
  final AppColorKey color;
  final bool vertical;
  final double thickness;
  final double space;
  final double? height;
  final double? width;
  final double opacity;

  /// Texto opcional para mostrar en medio del separador (solo horizontal)
  final String? label;

  const Separator({
    super.key,
    this.variant = SeparatorVariant.custom,
    this.color = AppColorKey.textSecondaryLight,
    this.vertical = false,
    this.thickness = 1, // Bajé el default a 1 para que sea una línea real
    this.space = 10,
    this.height,
    this.width,
    this.opacity = 1.0,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Si tiene texto y es horizontal, usamos la estructura de Row
    if (label != null && !vertical) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: space),
        child: Row(
          children: [
            Expanded(child: _buildSeparatorLine()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Font(
                text: label!,
                size: "sm", // Tamaño pequeño para que se vea como en la imagen
                color: color, // Mismo color que el separador
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(child: _buildSeparatorLine()),
          ],
        ),
      );
    }

    // Si no tiene texto, se comporta como el separador normal
    return _buildSeparatorLine();
  }

  /// Encapsula la lógica de construcción de la línea según la variante
  Widget _buildSeparatorLine() {
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
              margin:
                  label != null ? null : EdgeInsets.symmetric(vertical: space),
              color: resolved,
            );

    return opacity == 1.0 ? widget : Opacity(opacity: opacity, child: widget);
  }
}
