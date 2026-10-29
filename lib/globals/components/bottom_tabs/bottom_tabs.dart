import 'package:flutter/material.dart';
import 'package:template_flutter/globals/components/bottom_tabs/components/bottom_tab_item.dart';
import 'package:template_flutter/globals/components/bottom_tabs/models/bottom_tabs_model.dart';
import 'package:template_flutter/globals/theme/colors.dart';

class BottomTabs extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTapBottomItem;
  final List<TabData> items; // 👈 Array dinámico de pestañas
  final BottomTabsStyle style; // 👈 Configuración de estilos opcional

  const BottomTabs({
    super.key,
    required this.currentIndex,
    required this.onTapBottomItem,
    required this.items,
    this.style = const BottomTabsStyle(), // Estilo por defecto
  });

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double bottomSafeAreaHeight = MediaQuery.of(context).padding.bottom;
    const double barHeight = 65.0;

    // Resolvemos los colores usando el estilo proporcionado o los defaults
    final Color resolvedBarColor = widget.style.barColor ?? AppColors.white;
    final Color resolvedActiveCircleColor =
        widget.style.activeCircleColor ?? AppColors.primaryLight;

    // -------------------------------------------------------------
    // 🎯 MATEMÁTICA DINÁMICA (Soporta N cantidad de pestañas)
    // -------------------------------------------------------------
    final int totalTabs = widget.items.length;
    final double itemWidth = widget.style.itemWidth;

    final double remainingSpace = size.width - (itemWidth * totalTabs);
    final double spaceBetween = remainingSpace / (totalTabs + 1);

    final double tabCenter =
        (spaceBetween * (widget.currentIndex + 1)) +
        (itemWidth * widget.currentIndex) +
        (itemWidth / 2);

    return Container(
      color: Colors.transparent,
      height: barHeight + bottomSafeAreaHeight + 45,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // -------------------------------------------------------------
          // CAPA 1: Fondo Blanco con Hueco Animado
          // -------------------------------------------------------------
          Positioned.fill(
            top: 15,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: tabCenter, end: tabCenter),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, animatedCenter, child) {
                return CustomPaint(
                  painter: BottomBarPainter(
                    notchCenter: animatedCenter,
                    activeItemSize: widget.style.activeItemSize,
                    barColor: resolvedBarColor, // Pasamos el color al pintor
                  ),
                );
              },
            ),
          ),

          // -------------------------------------------------------------
          // CAPA 2: Los círculos de color (Generados dinámicamente)
          // -------------------------------------------------------------
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                totalTabs,
                (index) => _buildScaleCircle(
                  index,
                  itemWidth,
                  resolvedActiveCircleColor,
                ),
              ),
            ),
          ),

          // -------------------------------------------------------------
          // CAPA 3: Elementos Interactivos (Generados dinámicamente)
          // -------------------------------------------------------------
          Positioned(
            bottom: bottomSafeAreaHeight,
            left: 0,
            right: 0,
            top: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                totalTabs,
                (index) => BottomTabItem(
                  icon: widget.items[index].icon,
                  label: widget.items[index].label,
                  isSelected: widget.currentIndex == index,
                  onTap: () => widget.onTapBottomItem(index),
                  style: widget.style, // Pasamos el estilo al hijo
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaleCircle(int index, double size, Color color) {
    return AnimatedScale(
      scale: widget.currentIndex == index ? 1 : 0,
      alignment: Alignment.bottomCenter,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInExpo,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryLight.withAlpha((0.25 * 255).toInt()),
              blurRadius: 27,
              spreadRadius: -5,
              offset: Offset(0, 13),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              blurRadius: 16,
              spreadRadius: -8,
              offset: Offset(0, 8),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// PINTOR DEL FONDO CON CORTE CURVO (NOTCH)
// =====================================================================
class BottomBarPainter extends CustomPainter {
  final double notchCenter;
  final double activeItemSize;
  final Color barColor;

  BottomBarPainter({
    required this.notchCenter,
    required this.activeItemSize,
    required this.barColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _getPath(size, notchCenter);

    canvas.drawShadow(path, Colors.black, 15.0, true);

    final paint =
        Paint()
          ..color = barColor
          ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  Path _getPath(Size size, double center) {
    final path = Path();
    const double topY = 10.0;
    const double cornerRadius = 24.0;

    final double holeWidth = activeItemSize * 1.5;
    final double depth = activeItemSize * 0.51;

    final double startX = center - (holeWidth / 2);
    final double endX = center + (holeWidth / 2);

    path.moveTo(0, size.height);
    path.lineTo(0, topY + cornerRadius);

    path.arcToPoint(
      Offset(cornerRadius, topY),
      radius: const Radius.circular(cornerRadius),
      clockwise: true,
    );

    if (startX > cornerRadius) {
      path.lineTo(startX, topY);
    }

    final double cpOffset = holeWidth * 0.30;

    path.cubicTo(
      startX + cpOffset,
      topY,
      center - cpOffset,
      topY + depth,
      center,
      topY + depth,
    );

    path.cubicTo(
      center + cpOffset,
      topY + depth,
      endX - cpOffset,
      topY,
      endX,
      topY,
    );

    if (endX < size.width - cornerRadius) {
      path.lineTo(size.width - cornerRadius, topY);
      path.arcToPoint(
        Offset(size.width, topY + cornerRadius),
        radius: const Radius.circular(cornerRadius),
        clockwise: true,
      );
    } else {
      path.lineTo(size.width, topY);
    }

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldRepaint(covariant BottomBarPainter oldDelegate) {
    return oldDelegate.notchCenter != notchCenter ||
        oldDelegate.activeItemSize != activeItemSize ||
        oldDelegate.barColor != barColor;
  }
}
