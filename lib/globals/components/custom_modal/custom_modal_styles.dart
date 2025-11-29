import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Estilos base del CustomModal.
///
/// Centralizo aquí:
/// - colores
/// - padding
/// - radio de bordes
///
class CustomModalStyles {
  static final base = BaseModalStyles();
}

/// Estilos concretos del modal.
class BaseModalStyles {
  /// Padding interno del contenido.
  ///
  /// Aplico un padding para:
  /// - formularios
  /// - textos largos
  /// - componentes tipo Message
  ///
  final EdgeInsets padding = const EdgeInsets.all(20);

  /// Radio de bordes del modal.
  final BorderRadius radius = BorderRadius.circular(12);

  /// Color de fondo del modal.
  AppColorKey get backgroundColor => AppColorKey.white;

  /// Color del backdrop (fondo oscuro detrás del modal).
  AppColorKey get backdropColor => AppColorKey.blackTransparent;
}
