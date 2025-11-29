import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../font/font.dart';
import 'custom_button_styles.dart';

/// Variantes disponibles del botón.
/// Definen el estilo base (color, borde, etc.)
enum ButtonVariant { primary, secondary, outline, outlineSecondary, disabled }

/// Botón reutilizable de la app.
///
/// - Maneja variantes (primary, secondary, outline, etc.)
/// - Respeta estado disabled
/// - Permite overrides para ajustes puntuales sin crear nuevos componentes
///
class CustomButton extends StatelessWidget {
  /// Texto que se muestra en el botón
  final String title;

  /// Variante visual del botón (define colores y bordes base)
  final ButtonVariant variant;

  /// Si está en true, el botón:
  /// - no responde al tap
  /// - reduce su opacidad
  /// - usa el estilo disabled
  final bool disabled;

  /// Acción que se ejecuta al presionar el botón
  /// (no se ejecuta si disabled = true)
  final VoidCallback? onPressed;

  // ===================== OVERRIDES =====================
  // Estos overrides son OPCIONALES y solo se usan cuando
  // se necesita personalizar el botón en un caso puntual.

  /// Padding interno del botón.
  /// Si no se define, se usa el padding base del diseño.
  final EdgeInsets? padding;

  /// Margen externo del botón.
  /// Útil para separar botones sin envolverlos en SizedBox o Padding.
  final EdgeInsets? margin;

  /// Decoración personalizada del contenedor.
  /// Permite sobreescribir completamente el BoxDecoration
  /// (por ejemplo, un borde o radio especial).
  final BoxDecoration? decorationOverride;

  /// Color del texto forzado manualmente.
  /// Si no se define, se usa el color correspondiente a la variante.
  final AppColorKey? textColorOverride;

  /// Tamaño del texto del botón.
  /// Debe coincidir con los tamaños definidos en el componente Font
  /// (por ejemplo: "sm", "base", "lg").
  final String? textSizeOverride;

  const CustomButton({
    super.key,
    required this.title,
    this.variant = ButtonVariant.primary,
    this.disabled = false,
    this.onPressed,
    this.padding,
    this.margin,
    this.decorationOverride,
    this.textColorOverride,
    this.textSizeOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Si el botón está deshabilitado, siempre se fuerza la variante disabled
    final usedVariant = disabled ? ButtonVariant.disabled : variant;

    // Determina si la variante es de tipo outline
    final isOutline =
        usedVariant == ButtonVariant.outline ||
        usedVariant == ButtonVariant.outlineSecondary;

    // Se usa la decoración por defecto según la variante,
    // a menos que se provea una decoración personalizada
    final decoration =
        decorationOverride ?? CustomButtonStyles.decoration(usedVariant);

    return Opacity(
      // Opacidad reducida cuando el botón está disabled
      opacity: disabled ? 0.4 : 1,
      child: Container(
        margin: margin,
        decoration: decoration,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            // Se usa siempre el radio base para evitar inconsistencias visuales
            borderRadius: CustomButtonStyles.baseRadius,

            // Efectos visuales del tap
            splashColor:
                disabled
                    ? Colors.transparent
                    : Colors.black.withValues(alpha: isOutline ? 0.12 : 0.15),
            highlightColor:
                disabled
                    ? Colors.transparent
                    : Colors.black.withValues(alpha: 0.05),

            // Si está disabled, el tap queda inactivo
            onTap: disabled ? null : onPressed,
            child: Container(
              // Padding interno del botón
              padding: padding ?? CustomButtonStyles.basePadding,
              child: Center(
                child: Font(
                  text: title,

                  // Color del texto dependiendo de la variante,
                  // o sobreescrito manualmente si se necesita
                  color:
                      textColorOverride ??
                      CustomButtonStyles.textColorKey(usedVariant),

                  // Tamaño de texto por defecto u override
                  size: textSizeOverride ?? "base",
                  fontVariant: "RobotoBold",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
