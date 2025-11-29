import 'package:flutter/material.dart';
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
  /// Texto a renderizar.
  final String text;

  /// Tamaño tipográfico.
  ///
  /// Valores soportados:
  /// xs, sm, base, lg, xl, 2xl, 3xl
  ///
  final String size;

  /// Variante de la fuente.
  ///
  /// Ej:
  /// - RobotoRegular
  /// - RobotoBold
  /// - RobotoCondensedBold
  ///
  final String fontVariant;

  /// Color del texto usando el sistema de colores de la app.
  final AppColorKey? color;

  /// Color personalizado directo.
  /// Tiene prioridad sobre `color` cuando se envía.
  final Color? customColor;

  /// Estilos adicionales que se mezclan sobre el estilo base.
  final TextStyle? style;

  /// Alineación del texto.
  final TextAlign? align;

  /// Máximo de líneas a mostrar.
  final int? maxLines;

  /// Comportamiento del overflow.
  final TextOverflow? overflow;

  /// Callback opcional para hacer el texto clickeable.
  final VoidCallback? onTap;

  const Font({
    super.key,
    required this.text,
    this.size = "base",
    this.fontVariant = "RobotoRegular",
    this.color = AppColorKey.black,
    this.customColor,
    this.style,
    this.align,
    this.maxLines,
    this.overflow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Construyo el estilo final a partir del sistema tipográfico
    final finalStyle = FontStyles.build(
      size: size,
      fontVariant: fontVariant,
      color: color,
      customColor: customColor,
      extraStyle: style,
    );

    final textWidget = Text(
      text,
      textAlign: align,
      style: finalStyle,
      maxLines: maxLines,
      overflow: overflow,
    );

    // El texto solo es interactivo si se envía el callback
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
