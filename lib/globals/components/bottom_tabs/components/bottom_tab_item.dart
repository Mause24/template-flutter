import 'package:flutter/material.dart';
import 'package:template_flutter/globals/components/bottom_tabs/models/bottom_tabs_model.dart';
import 'package:template_flutter/globals/components/components.dart';

// Asegúrate de importar donde definiste BottomTabsStyle

class BottomTabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final BottomTabsStyle style;

  const BottomTabItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    // Resolvemos los colores dinámicamente
    final iconColor =
        isSelected
            ? (style.activeIconColor ?? Colors.white)
            : (style.inactiveIconColor ?? Colors.grey.shade400);

    // Resolvemos el TextSyle dinámicamente
    final textStyle =
        isSelected
            ? (style.activeTextStyle ??
                TextStyle(
                  color: iconColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ))
            : (style.inactiveTextStyle ??
                TextStyle(
                  color: iconColor,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        width: style.itemWidth, // Usa el ancho de los estilos
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8.0),
        alignment: isSelected ? const Alignment(0, -2) : const Alignment(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Icon(icon, color: iconColor, size: 26),
            Font(text: label, style: textStyle, maxLines: 1),
          ],
        ),
      ),
    );
  }
}
