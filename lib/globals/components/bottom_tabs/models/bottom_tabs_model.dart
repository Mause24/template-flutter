// Modelo para la información de cada pestaña
import 'package:flutter/material.dart';

class TabData {
  final IconData icon;
  final String label;

  const TabData({required this.icon, required this.label});
}

// Configuración de estilos visuales
class BottomTabsStyle {
  final Color? barColor;
  final Color? activeCircleColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;
  final double itemWidth;
  final double activeItemSize; // Controla el ancho de la curva y el círculo

  const BottomTabsStyle({
    this.barColor,
    this.activeCircleColor,
    this.activeIconColor,
    this.inactiveIconColor,
    this.activeTextStyle,
    this.inactiveTextStyle,
    this.itemWidth = 75.0,
    this.activeItemSize = 120.0,
  });
}
