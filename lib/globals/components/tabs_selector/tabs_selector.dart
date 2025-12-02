import 'package:flutter/material.dart';
import '../font/font.dart';
import '../../theme/colors.dart';
import '../tabs/tabs_shared_styles.dart';
import '../tabs/tabs.dart';

/// Selector visual de Tabs.
///
/// Renderiza:
/// - fondo común
/// - indicador animado del tab activo
/// - textos interactivos
///
/// No maneja contenido, solo selección.
///
class TabsSelector extends StatelessWidget {
  /// Labels de los tabs.
  final List<String> tabs;

  /// Índice activo.
  final int active;

  /// Variante visual.
  final TabsVariant variant;

  /// Callback al seleccionar un tab.
  final void Function(int index, String label) onChange;

  const TabsSelector({
    super.key,
    required this.tabs,
    required this.active,
    required this.onChange,
    this.variant = TabsVariant.defaultVariant,
  });

  @override
  Widget build(BuildContext context) {
    final s = TabsSharedStyles(variant: variant);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ancho disponible real
        final horizontalPadding = 8 * 2;
        final innerWidth =
            constraints.maxWidth - horizontalPadding;

        // Cada tab ocupa el mismo ancho
        final tabWidth = innerWidth / tabs.length;

        return Container(
          padding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: s.backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // ===== Indicador activo animado =====
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                left: active * tabWidth,
                width: tabWidth,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.activePaddingH,
                      vertical: s.activePaddingV,
                    ),
                    decoration: BoxDecoration(
                      color: s.activeColor,
                      borderRadius:
                          BorderRadius.circular(s.itemRadius),
                    ),
                  ),
                ),
              ),

              // ===== Textos =====
              Row(
                children: List.generate(tabs.length, (i) {
                  final isActive = i == active;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChange(i, tabs[i]),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s.activePaddingH,
                          vertical: s.activePaddingV,
                        ),
                        child: Center(
                          child: Font(
                            text: tabs[i],
                            size:
                                isActive ? "base" : "sm",
                            fontVariant: "RobotoBold",
                            color: isActive
                                ? AppColorKey.white
                                : AppColorKey.greyBlack,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
