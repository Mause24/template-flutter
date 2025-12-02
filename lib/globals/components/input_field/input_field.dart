import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../font/font.dart';
import 'input_field_styles.dart';
import '../../theme/colors.dart';

/// Variantes visuales del InputField.
///
/// - primary: campo con contenedor completo (background + border)
/// - secondary: campo más liviano con borde inferior
///
enum InputFieldVariant { primary, secondary }

/// Campo de texto reutilizable del sistema.
///
/// Este componente centraliza:
/// - estilos
/// - iconos internos
/// - manejo de errores
/// - variantes visuales
///
class InputField extends StatelessWidget {
  /// Variante visual del input.
  final InputFieldVariant variant;

  /// Título opcional que se muestra encima del campo.
  final String? title;

  /// Ícono opcional junto al título.
  final Widget? titleIcon;

  /// Ícono a la izquierda del campo.
  final Widget? leftIcon;

  /// Ícono a la derecha del campo.
  final Widget? rightIcon;

  /// Mensaje de error opcional.
  /// Si no es null, se muestra debajo del campo.
  final String? error;

  /// Placeholder del campo.
  final String? placeholder;

  /// Color personalizado del placeholder.
  final Color? placeholderColor;

  /// Controller del TextField.
  final TextEditingController? controller;

  /// Tipo de teclado (email, number, text, etc.).
  final TextInputType? keyboardType;

  /// Indica si el texto debe ocultarse (passwords).
  final bool obscureText;

  /// Habilita o deshabilita el campo.
  final bool enabled;

  /// Si es true, el campo no es editable pero sigue siendo interactivo.
  final bool readOnly;

  /// Callback al cambiar el texto.
  final void Function(String)? onChange;

  /// Callback al tocar el campo.
  final VoidCallback? onTap;

  /// FocusNode externo.
  /// Permite manejar el foco desde fuera (formularios, validaciones, etc.).
  final FocusNode? focusNode;

  /// InputFormatters opcionales.
  /// Útiles para máscaras, validaciones de entrada, etc.
  final List<TextInputFormatter>? inputFormatters;

  const InputField({
    super.key,
    this.variant = InputFieldVariant.primary,
    this.title,
    this.titleIcon,
    this.leftIcon,
    this.rightIcon,
    this.error,
    this.placeholder,
    this.placeholderColor,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChange,
    this.onTap,
    this.focusNode,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == InputFieldVariant.primary;
    final decoration = InputFieldStyles.container(variant);
    final fieldStyle = InputFieldStyles.field(variant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Title =====
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                if (titleIcon != null) titleIcon!,
                Font(
                  text: title!,
                  size: "sm",
                  fontVariant: isPrimary ? "RobotoRegular" : "RobotoBold",
                  color: isPrimary ? AppColorKey.black : AppColorKey.primary,
                ),
              ],
            ),
          ),

        // ===== Field =====
        Container(
          height: isPrimary ? 42 : 40,
          decoration: decoration,
          child: Row(
            children: [
              // Ícono izquierdo
              if (leftIcon != null)
                Padding(
                  padding: InputFieldStyles.leftPadding(variant),
                  child: leftIcon!,
                ),

              // Campo de texto
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  obscureText: obscureText,
                  enabled: enabled,
                  readOnly: readOnly,
                  onTap: onTap,
                  style: fieldStyle,
                  onChanged: onChange,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: TextStyle(
                      color:
                          placeholderColor ??
                          AppColors.fromKey(AppColorKey.greyBlack),
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),

              // Ícono derecho
              if (rightIcon != null)
                Padding(
                  padding: InputFieldStyles.rightPadding(variant),
                  child: rightIcon!,
                ),
            ],
          ),
        ),

        // ===== Error =====
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Font(text: error!, size: "sm", color: AppColorKey.red),
          ),
      ],
    );
  }
}
