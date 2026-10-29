import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/colors.dart';
import '../font/font.dart';
import 'input_field_styles.dart';

enum InputFieldVariant { primary, secondary }

class InputField extends StatefulWidget {
  final InputFieldVariant variant;
  final String? title;
  final Widget? titleIcon;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final String? error;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final void Function(String)? onChange;
  final String? Function(String?)?
  validator; // Nuevo: Soporte para validación nativa
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onBlur; // <--- Agregamos esto
  final double heightField;

  const InputField({
    super.key,
    this.variant = InputFieldVariant.primary,
    this.title,
    this.titleIcon,
    this.leftIcon,
    this.rightIcon,
    this.error,
    this.placeholder,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChange,
    this.validator,
    this.focusNode,
    this.inputFormatters,
    this.onBlur,
    this.heightField = 40,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _isObscured;
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    _isObscured = widget.obscureText;
    _internalFocusNode = widget.focusNode ?? FocusNode();

    // Escuchamos los cambios de foco
    _internalFocusNode.addListener(() {
      if (!_internalFocusNode.hasFocus) {
        // Cuando pierde el foco, ejecutamos el callback
        widget.onBlur?.call();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = widget.variant == InputFieldVariant.primary;
    final decoration = InputFieldStyles.container(widget.variant);
    final fieldStyle = InputFieldStyles.field(widget.variant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                if (widget.titleIcon != null) widget.titleIcon!,
                Font(
                  text: widget.title!,
                  size: "sm",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  color:
                      isPrimary ? AppColorKey.black : AppColorKey.primaryLight,
                ),
              ],
            ),
          ),

        // Usamos GestureDetector para que todo el contenedor sea clickeable
        GestureDetector(
          onTap: () => _internalFocusNode.requestFocus(),
          child: Container(
            height:
                widget.heightField, // Un poco más de altura para evitar cortes
            decoration: decoration,
            child: Row(
              children: [
                if (widget.leftIcon != null)
                  Padding(
                    padding: InputFieldStyles.leftPadding(widget.variant),
                    child: widget.leftIcon!,
                  ),

                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: _internalFocusNode,
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.inputFormatters,
                    obscureText: _isObscured,
                    enabled: widget.enabled,
                    readOnly: widget.readOnly,
                    style: fieldStyle,
                    onChanged: widget.onChange,
                    validator: widget.validator,
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      hintStyle: TextStyle(
                        color: AppColors.textPrimaryLight.withAlpha(
                          (0.5 * 255).toInt(),
                        ),
                      ),
                      border: InputBorder.none,
                      isDense:
                          true, // Mejor que isCollapsed para alineación vertical
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),

                // Lógica de Ojo para Password o ícono personalizado
                if (widget.obscureText)
                  IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _isObscured = !_isObscured),
                  )
                else if (widget.rightIcon != null)
                  Padding(
                    padding: InputFieldStyles.rightPadding(widget.variant),
                    child: widget.rightIcon!,
                  ),
              ],
            ),
          ),
        ),

        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Font(
              text: widget.error!,
              size: "sm",
              style: TextStyle(fontWeight: FontWeight.bold),
              color: AppColorKey.errorLight,
            ),
          ),
      ],
    );
  }
}
