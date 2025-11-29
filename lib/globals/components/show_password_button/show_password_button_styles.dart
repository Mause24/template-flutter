import 'package:flutter/material.dart';
import 'show_password_button.dart';

/// Estilos del ShowPasswordButton.
///
/// Centraliza:
/// - tamaño del ícono
/// - íconos visibles / ocultos
/// - variantes visuales
///
class ShowPasswordButtonStyles {
  /// Tamaño estándar del ícono.
  final double iconSize = 24;

  /// Retorna el ícono cuando la contraseña
  /// está oculta (mostrar).
  IconData iconVisible(ShowPasswordButtonVariant variant) {
    switch (variant) {
      case ShowPasswordButtonVariant.normal:
        return Icons.visibility;

      case ShowPasswordButtonVariant.accent:
        return Icons.visibility_rounded;

      case ShowPasswordButtonVariant.bold:
        // Variante visual más pesada (no existe "bold" real)
        return Icons.remove_red_eye;

      case ShowPasswordButtonVariant.thin:
        return Icons.visibility_outlined;
    }
  }

  /// Retorna el ícono cuando la contraseña
  /// está visible (ocultar).
  IconData iconHidden(ShowPasswordButtonVariant variant) {
    switch (variant) {
      case ShowPasswordButtonVariant.normal:
        return Icons.visibility_off;

      case ShowPasswordButtonVariant.accent:
        return Icons.visibility_off_rounded;

      case ShowPasswordButtonVariant.bold:
        // No existe versión bold real,
        // se usa el más cercano
        return Icons.visibility_off;

      case ShowPasswordButtonVariant.thin:
        return Icons.visibility_off_outlined;
    }
  }
}
