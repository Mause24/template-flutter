import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'date_field_styles.dart';
import '../date_modal/date_modal.dart';

/// Campo de selección de fecha.
///
/// Este componente funciona como un input visual que:
/// - muestra un placeholder o la fecha seleccionada
/// - abre un modal de calendario al tocarlo
/// - maneja estados de error
/// - permite título opcional con ícono
///
/// No almacena estado de fecha internamente,
/// la fecha siempre viene controlada desde fuera (controlled field).
///
class DateField extends StatefulWidget {
  /// Valor actual del campo.
  /// Si es null, se muestra el placeholder.
  final DateTime? value;

  /// Callback que notifica la fecha seleccionada.
  final void Function(DateTime) onChange;

  /// Texto que se muestra cuando no hay fecha seleccionada.
  final String placeholder;

  /// Título opcional que se muestra arriba del campo.
  final String? title;

  /// Ícono opcional que acompaña al título.
  final Widget? titleIcon;

  /// Mensaje de error (opcional).
  /// Si no es null, se muestra debajo del campo
  /// y el estilo cambia a estado de error.
  final String? error;

  const DateField({
    super.key,
    this.value,
    required this.onChange,
    this.placeholder = "Seleccione una fecha...",
    this.title,
    this.titleIcon,
    this.error,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  /// Formatea la fecha en formato DD/MM/YYYY.
  ///
  /// Lo mantengo interno para:
  /// - centralizar el formato
  /// - facilitar cambios futuros
  ///
  String _format(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return "$dd/$mm/$yy";
  }

  /// Abre el modal de selección de fecha.
  ///
  /// Uso showDialog con fondo transparente y backdrop oscuro
  /// para mantener consistencia visual con el sistema de modals.
  ///
  Future<void> _openModal() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.fromKey(AppColorKey.blackTransparent),
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 24,
          ),
          backgroundColor: Colors.transparent,
          child: DateModal(
            initialDate: widget.value,
            onCancel: () => Navigator.of(ctx).pop(),
            onConfirm: (d) {
              // Notifico el cambio hacia afuera
              widget.onChange(d);
              Navigator.of(ctx).pop();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = DateFieldStyles();

    final hasError = widget.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Title =====
        // Renderizo el título solo si existe texto o ícono
        if (widget.title != null || widget.titleIcon != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.titleIcon != null) widget.titleIcon!,
                if (widget.title != null)
                  Text(widget.title!, style: s.titleTextStyle),
              ],
            ),
          ),

        // ===== Field =====
        // Uso InkWell para capturar el tap
        // y mostrar feedback táctil
        InkWell(
          onTap: _openModal,
          borderRadius: s.fieldRadius,
          child: Container(
            padding: s.fieldPadding,
            decoration: s.fieldDecoration(hasError),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texto del valor o placeholder
                Expanded(
                  child: Text(
                    widget.value != null
                        ? _format(widget.value!)
                        : widget.placeholder,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: s.valueTextStyle(
                      filled: widget.value != null,
                      hasError: hasError,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Ícono del calendario
                Icon(
                  Icons.calendar_month,
                  size: 22,
                  color:
                      hasError
                          ? AppColors.fromKey(AppColorKey.error)
                          : AppColors.fromKey(AppColorKey.primary),
                ),
              ],
            ),
          ),
        ),

        // ===== Error =====
        // Render del mensaje de error si existe
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(widget.error!, style: s.errorTextStyle),
          ),
      ],
    );
  }
}
