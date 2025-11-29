import 'package:flutter/material.dart';
import 'select_field_styles.dart';

/// Variantes visuales del SelectField.
///
/// - primary: estilo con caja completa
/// - secondary: estilo liviano con borde inferior
///
enum SelectFieldVariant { primary, secondary }

/// Opción seleccionable genérica.
///
/// Se usa tanto para renderizar el label
/// como para retornar el valor real.
///
class SelectItemOption<T> {
  final String label;
  final T value;

  const SelectItemOption({required this.label, required this.value});
}

/// Builder custom para renderizar los ítems del dropdown.
///
/// Permite modificar completamente
/// la UI de cada opción.
///
typedef SelectItemBuilder<T> =
    Widget Function(VoidCallback onTap, SelectItemOption<T> item);

/// Select personalizado del sistema.
///
/// Este componente:
/// - reemplaza `DropdownButton` de Flutter
/// - usa Overlay para evitar problemas de layout
/// - soporta animaciones, estilos y builders custom
///
/// Casos de uso:
/// - selects simples
/// - selects con íconos
/// - selects complejos (ej: países, meses, etc.)
///
class SelectField<T> extends StatefulWidget {
  /// Opciones disponibles.
  final List<SelectItemOption<T>> options;

  /// Valor seleccionado actualmente.
  final SelectItemOption<T>? value;

  /// Callback al seleccionar una opción.
  final void Function(SelectItemOption<T>) onChange;

  /// Placeholder cuando no hay valor.
  final String placeholder;

  /// Variante visual del select.
  final SelectFieldVariant variant;

  /// Ícono opcional a la izquierda del campo.
  final Widget? leftIcon;

  /// Título opcional sobre el campo.
  final String? title;

  /// Ícono opcional junto al título.
  final Widget? titleIcon;

  /// Mensaje de error opcional.
  final String? error;

  /// Builder personalizado para los items del dropdown.
  final SelectItemBuilder<T>? itemBuilder;

  /// Altura máxima del dropdown.
  final double dropdownMaxHeight;

  /// Elevación del dropdown.
  final double dropdownElevation;

  /// Callback cuando se abre o cierra el dropdown.
  final void Function(bool)? onDropdownToggle;

  /// Ancho custom del dropdown.
  ///
  /// Si no se envía, usa el ancho del campo.
  ///
  final double? dropdownWidth;

  /// Permite inyectar estilos personalizados.
  final SelectFieldStyles? customStyles;

  const SelectField({
    super.key,
    required this.options,
    required this.onChange,
    this.value,
    this.placeholder = "Seleccione...",
    this.variant = SelectFieldVariant.secondary,
    this.leftIcon,
    this.title,
    this.titleIcon,
    this.error,
    this.itemBuilder,
    this.dropdownMaxHeight = 240,
    this.dropdownElevation = 6,
    this.onDropdownToggle,
    this.dropdownWidth,
    this.customStyles,
  });

  @override
  State<SelectField<T>> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T> extends State<SelectField<T>>
    with TickerProviderStateMixin {
  /// Key del campo para calcular posición global.
  final GlobalKey _fieldKey = GlobalKey();

  /// Overlay del dropdown.
  OverlayEntry? _overlay;

  /// Controladores de animación.
  late final AnimationController _dropdownCtrl;
  late final AnimationController _arrowCtrl;

  /// Animaciones del dropdown.
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  /// Rect del campo (posición y tamaño).
  Rect _fieldRect = Rect.zero;

  @override
  void initState() {
    super.initState();

    _dropdownCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _arrowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 0.5,
    );

    _scale = CurvedAnimation(parent: _dropdownCtrl, curve: Curves.easeOutCubic);

    _fade = CurvedAnimation(parent: _dropdownCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _removeOverlay();
    _dropdownCtrl.dispose();
    _arrowCtrl.dispose();
    super.dispose();
  }

  /// Calcula el rect del campo en pantalla.
  ///
  /// Se usa para posicionar correctamente el dropdown.
  ///
  void _calcFieldRect() {
    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final pos = box.localToGlobal(Offset.zero);
    _fieldRect = Rect.fromLTWH(pos.dx, pos.dy, box.size.width, box.size.height);
  }

  /// Toggle del dropdown.
  void _toggle() => _overlay == null ? _openOverlay() : _removeOverlay();

  /// Abre el dropdown usando Overlay.
  void _openOverlay() {
    _calcFieldRect();
    widget.onDropdownToggle?.call(true);
    _arrowCtrl.forward();

    final s = widget.customStyles ?? SelectFieldStyles.of(widget.variant);

    _overlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Capa para cerrar al tocar afuera
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeOverlay,
                behavior: HitTestBehavior.translucent,
                child: const SizedBox(),
              ),
            ),

            // Dropdown
            Positioned(
              left: _fieldRect.left,
              top: _fieldRect.top + _fieldRect.height + 4,
              width: widget.dropdownWidth ?? _fieldRect.width,
              child: Material(
                color: Colors.transparent,
                elevation: widget.dropdownElevation,
                borderRadius: s.dropdownRadius,
                child: FadeTransition(
                  opacity: _fade,
                  child: ScaleTransition(
                    alignment: Alignment.topCenter,
                    scale: _scale,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: widget.dropdownMaxHeight,
                      ),
                      child: Container(
                        decoration: s.dropdownDecoration,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          itemBuilder: (context, i) {
                            final item = widget.options[i];

                            void onTap() {
                              widget.onChange(item);
                              _removeOverlay();
                            }

                            // Builder custom si existe
                            if (widget.itemBuilder != null) {
                              return widget.itemBuilder!(onTap, item);
                            }

                            // Render por defecto
                            return InkWell(
                              onTap: onTap,
                              child: Padding(
                                padding: s.itemPadding,
                                child: Text(item.label, style: s.itemTextStyle),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlay!);
    _dropdownCtrl.forward(from: 0);
  }

  /// Cierra y elimina el dropdown.
  void _removeOverlay() {
    if (_overlay != null) {
      widget.onDropdownToggle?.call(false);
      _arrowCtrl.reverse();
      _dropdownCtrl.reverse().whenComplete(() {
        _overlay?.remove();
        _overlay = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.customStyles ?? SelectFieldStyles.of(widget.variant);

    final arrowColor = s.inverted ? Colors.white : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Title =====
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
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: s.fieldHeight),
          child: Container(
            key: _fieldKey,
            alignment: Alignment.centerLeft,
            padding: s.fieldPadding,
            decoration: s.fieldDecoration,
            child: InkWell(
              borderRadius: s.fieldRadius,
              onTap: _toggle,
              child: Row(
                children: [
                  if (widget.leftIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: widget.leftIcon!,
                    ),

                  // Valor / placeholder
                  Expanded(
                    child: Text(
                      widget.value?.label ?? widget.placeholder,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: s.valueTextStyle(widget.value != null),
                    ),
                  ),

                  const SizedBox(width: 6),

                  // Flecha con animación
                  RotationTransition(
                    turns: _arrowCtrl,
                    child: Icon(Icons.expand_more, color: arrowColor, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ===== Error =====
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Text(widget.error!, style: s.errorTextStyle),
          ),
      ],
    );
  }
}
