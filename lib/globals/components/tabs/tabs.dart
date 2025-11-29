import 'package:flutter/material.dart';
import 'tabs_shared_styles.dart';
import '../tabs_selector/tabs_selector.dart';

/// Variantes visuales del sistema de Tabs.
///
/// - primary: estilo principal (usa color primario)
/// - defaultVariant: estilo secundario
///
enum TabsVariant { primary, defaultVariant }

/// Componente Tabs.
///
/// Orquesta:
/// - selector visual de tabs (TabsSelector)
/// - contenido asociado a cada tab
///
class Tabs extends StatefulWidget {
  /// Labels de cada tab.
  final List<String> tabs;

  /// Contenido asociado a cada tab.
  ///
  /// Debe tener la misma longitud que `tabs`.
  ///
  final List<Widget> children;

  /// Variante visual.
  final TabsVariant variant;

  /// Indica si el cambio de contenido es animado.
  ///
  /// true  → animateToPage
  /// false → jumpToPage
  ///
  final bool animatedContent;

  /// Callback al cambiar de tab.
  ///
  /// Retorna:
  /// - índice
  /// - label del tab
  ///
  final void Function(int index, String label)? onTabChange;

  const Tabs({
    super.key,
    required this.tabs,
    required this.children,
    this.variant = TabsVariant.defaultVariant,
    this.animatedContent = true,
    this.onTabChange,
  });

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  /// Controla el scroll horizontal del contenido.
  late PageController controller;

  /// Tab actualmente activo.
  int activeTab = 0;

  /// Estilos compartidos (Tabs + TabsSelector).
  late TabsSharedStyles s;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    s = TabsSharedStyles(variant: widget.variant);
  }

  /// Maneja el cambio de tab desde el selector.
  void _changeTab(int i, String label) {
    setState(() => activeTab = i);
    widget.onTabChange?.call(i, label);

    if (widget.animatedContent) {
      controller.animateToPage(
        i,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      controller.jumpToPage(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ===== Selector de Tabs =====
        TabsSelector(
          tabs: widget.tabs,
          active: activeTab,
          variant: widget.variant,
          onChange: _changeTab,
        ),

        const SizedBox(height: 16),

        // ===== Contenido =====
        //
        // PageView permite:
        // - swipe manual
        // - animación fluida
        // - sincronización con el selector
        //
        SizedBox(
          height: 300, // ajustable según el contenido real
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => activeTab = index);
            },
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
