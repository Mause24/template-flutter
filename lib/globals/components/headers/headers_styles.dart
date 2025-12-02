import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Estilos del Header.
///
/// Centralizo aquí:
/// - tamaños
/// - paddings
/// - colores
///
class HeaderStyles {
  /// Altura fija del header principal.
  static const double height = 100;

  /// Estilos base compartidos.
  static final base = _BaseHeaderStyles();
}

/// Estilos concretos del header base.
class _BaseHeaderStyles {
  /// Padding superior del header base.
  ///
  /// Compensa el status bar y mantiene
  /// separación visual adecuada.
  ///
  final EdgeInsets basePadding = const EdgeInsets.only(top: 24);

  /// Padding del botón "volver".
  ///
  /// Asegura área táctil cómoda.
  ///
  final EdgeInsets backPadding = const EdgeInsets.only(left: 15, right: 10);

  /// Padding del header tipo menú.
  final EdgeInsets menuPadding = const EdgeInsets.all(16);

  /// Color de fondo del header base.
  AppColorKey get backgroundColor => AppColorKey.primary;

  /// Color de los íconos.
  AppColorKey get iconColor => AppColorKey.white;

  /// Altura del header.
  double get height => HeaderStyles.height;
}
