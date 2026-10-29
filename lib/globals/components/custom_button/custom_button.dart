import 'package:flutter/material.dart';
import 'package:template_flutter/globals/theme/typography.dart';

import '../font/font.dart';
import 'custom_button_styles.dart';

/// Define las variantes visuales que determinan la personalidad del botón.
enum ButtonVariant {
  primary,
  secondary,
  alternate,
  outline,
  outlineSecondary,
  disabled,
}

/// Componente de botón de alto nivel para el sistema MaMá.
///
/// Soporta estados de carga, deshabilitado, múltiples variantes visuales
/// y personalización profunda mediante overrides.
class CustomButton extends StatelessWidget {
  /// El texto principal que comunica la acción (ej: "Crear cuenta").
  final String title;

  /// La estética base del botón definida en el sistema de diseño.
  final ButtonVariant variant;

  /// Controla si el botón ignora las interacciones del usuario.
  final bool disabled;

  /// Estado de carga: reemplaza el texto por un spinner y bloquea el tap
  /// para evitar múltiples peticiones accidentales.
  final bool isLoading;

  /// Callback que se dispara al presionar, anulado si [disabled] o [isLoading] son true.
  final VoidCallback? onPressed;

  // ===================== OVERRIDES DE DISEÑO =====================
  // Permiten ajustes específicos sin romper la consistencia del componente.

  /// Espaciado interno para ajustar el área de impacto o el tamaño visual.
  final EdgeInsets? padding;

  /// Separación externa respecto a otros widgets hermanos.
  final EdgeInsets? margin;

  /// Permite inyectar una decoración completa (bordes, sombras, gradientes).
  final BoxDecoration? decorationOverride;

  /// Modificadores específicos para la fuente dentro del botón.
  final TextStyle? customTextStyle;

  const CustomButton({
    super.key,
    required this.title,
    this.variant = ButtonVariant.primary,
    this.disabled = false,
    this.isLoading = false,
    this.onPressed,
    this.padding,
    this.margin,
    this.decorationOverride,
    this.customTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Unificamos los estados de "no interacción" para simplificar la lógica.
    final bool isInactive = disabled || isLoading;

    // Si no es interactivo, forzamos visualmente la variante de deshabilitado.
    final usedVariant = isInactive ? ButtonVariant.disabled : variant;

    // Identificamos si es una variante con borde para ajustar el efecto de 'Splash'.
    final isOutline =
        usedVariant == ButtonVariant.outline ||
        usedVariant == ButtonVariant.outlineSecondary;

    // Resolvemos la decoración final: override > estilo por variante.
    final decoration =
        decorationOverride ?? CustomButtonStyles.decoration(usedVariant);

    // Extraemos el color de texto definido para la variante actual.
    final Color textColor = CustomButtonStyles.textColor(variant);

    // Construimos el estilo de texto base fusionando tipografía global y overrides.
    final textStyles = TextStyle(
      color: textColor,
      fontFamily: AppTypography.defaultFamily,
      fontWeight: FontWeight.bold,
    ).merge(customTextStyle);

    return Opacity(
      // Aplicamos una opacidad sutil para dar feedback visual de inactividad.
      opacity: isInactive ? 0.65 : 1.0,
      child: Container(
        margin: margin,
        decoration: decoration,
        child: Material(
          type:
              MaterialType
                  .transparency, // Evita que el Material tape la decoración del Container.
          child: InkWell(
            borderRadius: CustomButtonStyles.baseRadius,
            // Los colores de Splash y Highlight cambian según si el botón tiene fondo o solo borde.
            splashColor:
                isInactive
                    ? Colors.transparent
                    : Colors.black.withValues(alpha: isOutline ? 0.08 : 0.12),
            highlightColor:
                isInactive
                    ? Colors.transparent
                    : Colors.black.withValues(alpha: 0.05),

            // Si hay un proceso activo (isLoading), el tap se anula completamente.
            onTap: isInactive ? null : onPressed,

            child: Container(
              padding: padding ?? CustomButtonStyles.basePadding,
              // Establecemos una altura mínima para prevenir el 'jump' visual al alternar entre texto y loader.
              constraints: const BoxConstraints(minHeight: 48),
              child: Center(
                child:
                    isLoading
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            // Sincronizamos el color del loader con el color del texto para que siempre sea legible.
                            valueColor: AlwaysStoppedAnimation<Color>(
                              textColor,
                            ),
                          ),
                        )
                        : Font(text: title, style: textStyles),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
