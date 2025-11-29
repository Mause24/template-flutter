import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'checkbox_styles.dart';

/// Checkbox personalizado.
///
/// - admite cualquier widget como label (child)
/// - permite reemplazar el ícono del check
/// - respeta el sistema de colores de la app (AppColorKey)
/// - soporta mensajes de error y estilos dinámicos.
///
class CheckBox extends StatefulWidget {
  /// Estado inicial del checkbox.
  final bool checked;

  /// Texto o widget que acompaña al checkbox.
  final Widget? child;

  /// Ícono que se muestra cuando está marcado.
  /// Si no se envía, uso un check por defecto.
  final Widget? icon;

  /// Color del borde.
  final AppColorKey borderColor;

  /// Color del icono cuando está marcado.
  final AppColorKey checkColor;

  /// Color de fondo cuando está marcado.
  final AppColorKey backgroundColor;

  /// Mensaje de error opcional.
  final String? error;

  /// Callback para notificar cambios.
  /// Devuelvo el nuevo estado (true/false).
  final ValueChanged<bool>? onChange;

  const CheckBox({
    super.key,
    required this.checked,
    this.child,
    this.icon,

    this.borderColor = AppColorKey.black,
    this.checkColor = AppColorKey.white,
    this.backgroundColor = AppColorKey.primary,

    this.error,
    this.onChange,
  });

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  /// Estado interno del componente.
  /// Lo manejo manualmente para no depender de setState externo.
  late bool checked;

  @override
  void initState() {
    super.initState();
    // Inicializo el estado interno a partir de la propiedad inicial.
    checked = widget.checked;
  }

  /// Activa/desactiva el checkbox.
  /// También notifico el cambio al exterior si se envió el callback.
  void _toggle() {
    setState(() => checked = !checked);
    widget.onChange?.call(checked);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Área táctil completa para activar/desactivar.
        GestureDetector(
          onTap: _toggle,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              // Caja del checkbox con animación suave para cambios de estilo.
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: 24,
                height: 24,
                decoration:
                    checked
                        ? CheckBoxStyles.checked(
                          hasError: hasError,
                          borderColor: widget.borderColor,
                          backgroundColor: widget.backgroundColor,
                        )
                        : CheckBoxStyles.box(
                          hasError: hasError,
                          borderColor: widget.borderColor,
                        ),

                // Render del ícono solo cuando está marcado.
                child:
                    checked
                        ? Center(
                          child:
                              widget.icon ??
                              Icon(
                                Icons.check,
                                size: 18,
                                color: AppColors.fromKey(widget.checkColor),
                              ),
                        )
                        : null,
              ),

              const SizedBox(width: 8),

              // Texto o widget que acompaña al checkbox.
              widget.child ?? const SizedBox.shrink(),
            ],
          ),
        ),

        // Render del mensaje de error si existe.
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(widget.error!, style: CheckBoxStyles.errorStyle()),
          ),
      ],
    );
  }
}
