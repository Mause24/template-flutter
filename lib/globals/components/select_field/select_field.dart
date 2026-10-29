import 'package:flutter/material.dart';
import 'package:template_flutter/globals/components/font/font.dart';

import 'select_field_styles.dart';

enum SelectFieldVariant { primary, secondary }

class SelectItemOption<T> {
  final String label;
  final T value;
  const SelectItemOption({required this.label, required this.value});
}

typedef SelectItemBuilder<T> =
    Widget Function(VoidCallback onTap, SelectItemOption<T> item);

class SelectField<T> extends StatefulWidget {
  final List<SelectItemOption<T>> options;
  final SelectItemOption<T>? value;
  final void Function(SelectItemOption<T>) onChange;
  final String placeholder;
  final SelectFieldVariant variant;
  final Widget? leftIcon;
  final String? title;
  final Widget? titleIcon;
  final String? error;
  final SelectItemBuilder<T>? itemBuilder;
  final double dropdownMaxHeight;
  final double dropdownElevation;
  final void Function(bool)? onDropdownToggle;
  final double? dropdownWidth;
  final SelectFieldStyles? customStyles;
  final double fieldHeight;

  const SelectField({
    super.key,
    required this.options,
    required this.onChange,
    this.value,
    this.placeholder = "Seleccione...",
    this.variant = SelectFieldVariant.primary,
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
    this.fieldHeight = 40,
  });

  @override
  State<SelectField<T>> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T> extends State<SelectField<T>>
    with TickerProviderStateMixin {
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlay;
  late final AnimationController _dropdownCtrl;
  late final AnimationController _arrowCtrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
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

  void _calcFieldRect() {
    final RenderBox? box =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) {
      final pos = box.localToGlobal(Offset.zero);
      setState(() {
        _fieldRect = Rect.fromLTWH(
          pos.dx,
          pos.dy,
          box.size.width,
          box.size.height,
        );
      });
    }
  }

  void _toggle() => _overlay == null ? _openOverlay() : _removeOverlay();

  void _openOverlay() {
    // BUSCAMOS EL OVERLAY DEL NAVIGATOR RAÍZ
    final overlayState = Navigator.of(context, rootNavigator: true).overlay;
    _calcFieldRect();

    if (_fieldRect == Rect.zero || overlayState == null) return;

    widget.onDropdownToggle?.call(true);
    _arrowCtrl.forward();

    final stylesModal =
        widget.customStyles ?? SelectFieldStyles.of(widget.variant);

    _overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: _fieldRect.left,
            top: (_fieldRect.top + _fieldRect.height + 4).clamp(
              0,
              double.infinity,
            ),
            width: widget.dropdownWidth ?? _fieldRect.width,
            child: Material(
              color: Colors.transparent,
              elevation: widget.dropdownElevation,
              borderRadius: stylesModal.dropdownRadius,
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  alignment: Alignment.topCenter,
                  scale: _scale,
                  child: Container(
                    decoration: stylesModal.dropdownDecoration,
                    clipBehavior: Clip.antiAlias,
                    constraints: BoxConstraints(
                      maxHeight: widget.dropdownMaxHeight,
                    ),
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

                        if (widget.itemBuilder != null) {
                          return widget.itemBuilder!(onTap, item);
                        }
                        return InkWell(
                          onTap: onTap,
                          child: Padding(
                            padding: stylesModal.itemPadding,
                            child: Text(
                              item.label,
                              style: stylesModal.itemTextStyle,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlayState.insert(_overlay!);
    _dropdownCtrl.forward(from: 0);
  }

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
    final selectStyles =
        widget.customStyles ?? SelectFieldStyles.of(widget.variant);
    final arrowColor = selectStyles.inverted ? Colors.white : Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null || widget.titleIcon != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.titleIcon != null) widget.titleIcon!,
                if (widget.title != null)
                  Text(widget.title!, style: selectStyles.titleTextStyle),
              ],
            ),
          ),
        Container(
          key: _fieldKey,
          height: widget.fieldHeight,
          decoration: selectStyles.fieldDecoration,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggle,
              borderRadius: selectStyles.fieldRadius,
              child: Padding(
                padding: selectStyles.fieldPadding,
                child: Row(
                  children: [
                    if (widget.leftIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: widget.leftIcon!,
                      ),
                    Expanded(
                      child: Font(
                        text: widget.value?.label ?? widget.placeholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: selectStyles.valueTextStyle(
                          widget.value != null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    RotationTransition(
                      turns: _arrowCtrl,
                      child: Icon(
                        Icons.expand_more,
                        color: arrowColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 8),
            child: Text(widget.error!, style: selectStyles.errorTextStyle),
          ),
      ],
    );
  }
}
