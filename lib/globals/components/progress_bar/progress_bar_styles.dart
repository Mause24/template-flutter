import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Estilos del componente ProgressBar.
///
/// Centraliza:
/// - colores
/// - bordes
/// - estados activo / inactivo
///
class ProgressBarStyles {
  /// Barra de fondo (progreso total).
  static BoxDecoration backgroundBar() {
    return BoxDecoration(
      color: AppColors.fromKey(AppColorKey.gray),
      borderRadius: BorderRadius.circular(2),
    );
  }

  /// Barra de progreso activo.
  static BoxDecoration foregroundBar() {
    return BoxDecoration(
      color: AppColors.fromKey(AppColorKey.secondary),
      borderRadius: BorderRadius.circular(2),
    );
  }

  /// Punto inactivo.
  static BoxDecoration circleInactive() {
    return BoxDecoration(
      color: AppColors.fromKey(AppColorKey.gray),
      shape: BoxShape.circle,
    );
  }

  /// Punto activo.
  static BoxDecoration circleActive() {
    return BoxDecoration(
      color: AppColors.fromKey(AppColorKey.secondary),
      shape: BoxShape.circle,
    );
  }
}
