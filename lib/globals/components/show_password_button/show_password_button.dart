import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'show_password_button_styles.dart';

/// Variantes visuales del botón de mostrar/ocultar contraseña.
///
/// Cambian únicamente el estilo del ícono.
enum ShowPasswordButtonVariant { normal, accent, bold, thin }

/// Botón para alternar visibilidad de contraseñas.
///
/// Este componente:
/// - maneja su propio estado interno (shown / hidden)
/// - notifica el estado actual hacia afuera
/// - permite personalizar íconos y colores
///
/// Normalmente se usa dentro de un InputField
/// como ícono a la derecha.
///
class ShowPasswordButton extends StatefulWidget {
  /// Variante visual del ícono.
  final ShowPasswordButtonVariant variant;

  /// Color por defecto del ícono.
  final AppColorKey color;

  /// Color opcional cuando la contraseña está visible.
  ///
  /// Si no se envía, se mantiene el color base.
  ///
  final AppColorKey? activeColor;

  /// Callback que notifica si la contraseña está visible.
  ///
  /// true  → visible
  /// false → oculta
  ///
  final ValueChanged<bool>? onToggle;

  const ShowPasswordButton({
    super.key,
    this.variant = ShowPasswordButtonVariant.normal,
    this.color = AppColorKey.gray,
    this.activeColor,
    this.onToggle,
  });

  @override
  State<ShowPasswordButton> createState() => _ShowPasswordButtonState();
}

class _ShowPasswordButtonState extends State<ShowPasswordButton> {
  /// Estado interno del botón.
  ///
  /// true  → contraseña visible
  /// false → contraseña oculta
  ///
  bool isShown = false;

  /// Alterna el estado y notifica al exterior.
  void _toggle() {
    setState(() => isShown = !isShown);
    widget.onToggle?.call(isShown);
  }

  @override
  Widget build(BuildContext context) {
    final styles = ShowPasswordButtonStyles();

    // Resuelve el color del ícono según el estado
    final Color resolvedColor = AppColors.fromKey(
      isShown && widget.activeColor != null
          ? widget.activeColor!
          : widget.color,
    );

    return GestureDetector(
      onTap: _toggle,
      child: Icon(
        isShown
            ? styles.iconHidden(widget.variant)
            : styles.iconVisible(widget.variant),
        size: styles.iconSize,
        color: resolvedColor,
      ),
    );
  }
}
