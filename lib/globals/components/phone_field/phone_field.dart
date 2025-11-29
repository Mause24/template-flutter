import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/colors.dart';
import '../input_field/input_field.dart';
import '../select_field/select_field.dart';
import '../../utils/countries.dart';
import 'phone_field_styles.dart';

/// Campo especializado para ingresar números de teléfono.
///
/// Combina:
/// - selector de país (con bandera y extensión)
/// - input numérico para el número
///
/// Retorna siempre el valor completo con extensión,
/// por ejemplo: `+57 3001234567`
///
/// Este componente:
/// - no expone el estado interno
/// - notifica cambios vía callback
/// - mantiene consistencia con InputField y SelectField
///
class PhoneField extends StatefulWidget {
  /// Callback que retorna el número completo (extensión + número).
  final void Function(String fullValue)? onChange;

  /// Placeholder del input numérico.
  final String placeholder;

  /// Variante visual del SelectField.
  ///
  /// De esta variante se deriva también la variante del InputField.
  ///
  final SelectFieldVariant variant;

  /// Título opcional del campo.
  final String? title;

  /// Ícono opcional junto al título.
  final Widget? titleIcon;

  /// Mensaje de error opcional.
  final String? error;

  const PhoneField({
    super.key,
    this.onChange,
    this.placeholder = "Ingrese su número de teléfono",
    this.variant = SelectFieldVariant.secondary,
    this.title,
    this.titleIcon,
    this.error,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  /// Extensión de país seleccionada.
  late SelectItemOption<String> _ext;

  /// Controller del input numérico.
  final TextEditingController _ctrl = TextEditingController();

  /// FocusNode del input.
  ///
  /// Permite devolver el foco al campo
  /// cuando se selecciona una extensión.
  ///
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Selecciono Colombia por defecto si existe.
    final co = countries.where((c) => c.countrySuffix == "co").toList();

    final initial = co.isNotEmpty ? co.first : countries.first;

    _ext = SelectItemOption(
      label: initial.phoneExtension,
      value: initial.countrySuffix,
    );
  }

  /// Notifica el valor completo hacia afuera.
  ///
  /// Formato:
  /// +XX NNNNNNNNN
  ///
  void _notify() {
    widget.onChange?.call("${_ext.label} ${_ctrl.text}");
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = PhoneFieldStyles();

    // Opciones del selector de países
    final opts =
        countries
            .map(
              (c) => SelectItemOption<String>(
                label: c.phoneExtension,
                value: c.countrySuffix,
              ),
            )
            .toList();

    /// Builder customizado para los items del dropdown.
    ///
    /// Muestra:
    /// - bandera
    /// - nombre local + nombre internacional
    /// - extensión telefónica
    ///
    Widget itemBuilder(VoidCallback onTap, SelectItemOption<String> item) {
      final c = countries.firstWhere(
        (cc) => cc.countrySuffix == item.value,
        orElse: () => countries.first,
      );

      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: s.itemPadding,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  c.flagUrl,
                  width: 28,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${c.localName} (${c.name})",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                c.phoneExtension,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Title =====
        if (widget.title != null || widget.titleIcon != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                if (widget.titleIcon != null) widget.titleIcon!,
                if (widget.title != null)
                  Text(widget.title!, style: s.titleTextStyle),
              ],
            ),
          ),

        // ===== Fields =====
        LayoutBuilder(
          builder: (context, constraints) {
            // Derivo la variante del InputField
            final inputVariant =
                widget.variant == SelectFieldVariant.primary
                    ? InputFieldVariant.primary
                    : InputFieldVariant.secondary;

            final double fieldHeight =
                inputVariant == InputFieldVariant.primary ? 44 : 40;

            return Row(
              children: [
                // ===== Country Select =====
                IntrinsicWidth(
                  child: SizedBox(
                    height: fieldHeight,
                    child: SelectField<String>(
                      options: opts,
                      value: _ext,
                      onChange: (opt) {
                        setState(() => _ext = opt);
                        _notify();

                        // Devuelvo el foco al input
                        _focusNode.requestFocus();
                      },
                      variant: widget.variant,
                      itemBuilder: itemBuilder,
                      dropdownWidth: constraints.maxWidth,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ===== Phone Input =====
                Expanded(
                  child: SizedBox(
                    height: fieldHeight,
                    child: InputField(
                      placeholder: widget.placeholder,
                      controller: _ctrl,
                      variant: inputVariant,
                      keyboardType: TextInputType.phone,
                      focusNode: _focusNode,
                      onChange: (_) => _notify(),

                      // Solo números
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // ===== Error =====
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Text(
              widget.error!,
              style: TextStyle(
                color: AppColors.fromKey(AppColorKey.red),
                fontSize: 12.5,
              ),
            ),
          ),
      ],
    );
  }
}
