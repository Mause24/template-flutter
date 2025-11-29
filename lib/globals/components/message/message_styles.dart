import 'package:flutter/material.dart';
import '../../theme/colors.dart';

/// Contenedor principal para los estilos del Message.
///
/// Expone una instancia base que puede reutilizarse
/// o extenderse para variantes futuras.
///
class MessageStyles {
  static final base = MessageBaseStyles();
}

///
/// Estilos base del componente Message.
///
/// Centraliza:
/// - paddings
/// - sombras
/// - bordes
/// - fondo
///
class MessageBaseStyles {
  /// Padding interno del modal.
  ///
  /// Mantiene separación consistente entre:
  /// - título
  /// - cuerpo
  /// - botones
  ///
  EdgeInsets get padding =>
      const EdgeInsets.symmetric(horizontal: 22, vertical: 20);

  /// Sombra del modal.
  ///
  /// Genera el efecto de elevación sobre el backdrop oscuro.
  ///
  List<BoxShadow> get shadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 22,
      spreadRadius: 1,
      offset: const Offset(0, 6),
    ),
  ];

  /// Radio del contenedor del Message.
  BorderRadius get borderRadius => BorderRadius.circular(18);

  /// Color de fondo del Message.
  ///
  /// Usando AppColors garantizo compatibilidad
  /// con el sistema de temas.
  ///
  Color get background => AppColors.fromKey(AppColorKey.white);
}
