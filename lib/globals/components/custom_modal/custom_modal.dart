import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'custom_modal_styles.dart';

/// Tipos de animación soportados por el CustomModal.
///
/// - fade: aparece/desaparece con opacidad
/// - slide: entra desde abajo
/// - zoom: efecto de escala
///
enum CustomModalAnimation { fade, slide, zoom }

/// Modal personalizado reutilizable.
///
/// Este componente lo uso como base para:
/// - dialogs
/// - confirmaciones
/// - alertas
/// - componentes tipo Message
///
/// Características:
/// - controlado por estado externo (`isOpen`)
/// - animaciones configurables
/// - backdrop con cierre opcional
/// - desacoplado del contenido (recibe cualquier widget como child)
///
class CustomModal extends StatefulWidget {
  /// Controla si el modal está abierto o cerrado.
  final bool isOpen;

  /// Contenido del modal.
  /// renderiza cualquier widget (forms, textos, botones, etc.).
  final Widget child;

  /// Callback que se ejecuta al cerrar el modal.
  /// Normalmente actualizo el estado externo aquí.
  final VoidCallback onClose;

  /// Tipo de animación al mostrar/ocultar el modal.
  final CustomModalAnimation animation;

  /// Duración de la animación de entrada y salida.
  final Duration duration;

  /// Indica si el modal se puede cerrar tocando el fondo.
  final bool dismissible;

  const CustomModal({
    super.key,
    required this.isOpen,
    required this.child,
    required this.onClose,
    this.animation = CustomModalAnimation.fade,
    this.duration = const Duration(milliseconds: 250),
    this.dismissible = true,
  });

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal>
    with SingleTickerProviderStateMixin {
  /// Controller principal de animaciones.
  late AnimationController controller;

  /// Animación de opacidad.
  late Animation<double> fade;

  /// Animación de desplazamiento (desde abajo).
  late Animation<Offset> slide;

  /// Animación de escala (zoom).
  late Animation<double> scale;

  /// Control interno de visibilidad.
  ///
  /// se usa para evitar que el modal
  /// desaparezca abruptamente antes de terminar la animación.
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.duration,
    );

    // Animación de fade
    fade = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    // Animación de slide (desde abajo)
    slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    // Animación de zoom
    scale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    // Listener para limpiar el widget al final de la animación de cierre
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && !_visible) {
        setState(() {});
      }
    });

    // Si arranca abierto, muestro el modal inmediatamente
    if (widget.isOpen) {
      _visible = true;
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomModal oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Abro el modal
    if (widget.isOpen && !oldWidget.isOpen) {
      _visible = true;
      controller.forward();
    }
    // Cierro el modal
    else if (!widget.isOpen && oldWidget.isOpen) {
      _visible = false;
      controller.reverse();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = CustomModalStyles.base;

    // Si ya terminó la animación de cierre, no renderiza nada
    if (!_visible && controller.status == AnimationStatus.dismissed) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Stack(
        children: [
          // Backdrop oscuro
          FadeTransition(
            opacity: fade,
            child: GestureDetector(
              onTap: widget.dismissible ? widget.onClose : null,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.fromKey(styles.backdropColor),
              ),
            ),
          ),

          // Contenido centrado con animación
          Center(child: _buildAnimation(styles)),
        ],
      ),
    );
  }

  /// Retorna el widget animado según el tipo de animación configurado.
  Widget _buildAnimation(BaseModalStyles styles) {
    switch (widget.animation) {
      case CustomModalAnimation.fade:
        return FadeTransition(opacity: fade, child: _modalBase(styles));

      case CustomModalAnimation.slide:
        return SlideTransition(position: slide, child: _modalBase(styles));

      case CustomModalAnimation.zoom:
        return ScaleTransition(scale: scale, child: _modalBase(styles));
    }
  }

  /// Estructura base visual del modal.
  ///
  /// - ancho limitado para desktop/tablet
  /// - padding y radius centralizados en styles
  ///
  Widget _modalBase(BaseModalStyles styles) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
      child: Container(
        padding: styles.padding,
        decoration: BoxDecoration(
          color: AppColors.fromKey(styles.backgroundColor),
          borderRadius: styles.radius,
        ),
        child: widget.child,
      ),
    );
  }
}
