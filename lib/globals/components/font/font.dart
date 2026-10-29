import 'package:flutter/material.dart';
import 'package:template_flutter/globals/theme/typography.dart';

import '../../theme/colors.dart';
import 'font_styles.dart';

/// Componente tipográfico base del sistema.
///
/// Este widget lo uso como reemplazo de `Text`
/// para garantizar:
/// - consistencia tipográfica
/// - uso de las fuentes del sistema
/// - tamaños estandarizados
/// - colores centralizados
///
class Font extends StatelessWidget {
  final String? text;
  final List<InlineSpan>? children;
  final String size;
  final String fontVariant;
  final AppColorKey? color;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final VoidCallback? onTap;

  const Font({
    super.key,
    required this.text,
    this.size = "base",
    this.fontVariant = AppTypography.defaultFamily,
    this.color = AppColorKey.black,
    this.style,
    this.align,
    this.maxLines,
    this.overflow,
    this.onTap,
  }) : children = null;

  // Constructor Nombrado para Rich Text
  const Font.rich({
    super.key,
    required this.children,
    this.size = "base",
    this.fontVariant = AppTypography.defaultFamily,
    this.color = AppColorKey.black,
    this.style,
    this.align,
    this.maxLines,
    this.overflow,
    this.onTap,
  }) : text = null;

  @override
  Widget build(BuildContext context) {
    final finalStyle = FontStyles.build(
      size: size,
      fontVariant: fontVariant,
      color: color,
      extraStyle: style,
    );

    // Decidimos qué widget de texto usar
    Widget textWidget;
    if (children != null) {
      textWidget = Text.rich(
        TextSpan(style: finalStyle, children: children),
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );
    } else {
      textWidget = Text(
        text ?? "",
        textAlign: align,
        style: finalStyle,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    if (onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: textWidget,
      );
    }

    return textWidget;
  }
}
