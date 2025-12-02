import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'tabs.dart';

/// Estilos compartidos entre Tabs y TabsSelector.
///
/// Mantiene consistencia visual:
/// - fondo
/// - color activo
/// - paddings
/// - radios
///
class TabsSharedStyles {
  final TabsVariant variant;

  /// Color de fondo del contenedor de tabs.
  late Color backgroundColor;

  /// Color del tab activo.
  late Color activeColor;

  /// Padding horizontal del tab activo.
  late double activePaddingH;

  /// Padding vertical del tab activo.
  late double activePaddingV;

  /// Radio del tab activo.
  late double itemRadius;

  TabsSharedStyles({required this.variant}) {
    backgroundColor = AppColors.grayInput;
    itemRadius = 6;

    // Color activo según variante
    if (variant == TabsVariant.primary) {
      activeColor = AppColors.primary;
    } else {
      activeColor = AppColors.secondary;
    }

    activePaddingH = 12;
    activePaddingV = 6;
  }
}
