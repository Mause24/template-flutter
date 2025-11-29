import 'package:flutter/material.dart';
import '../font/font.dart';
import 'progress_bar_styles.dart';
import '../../theme/colors.dart';

/// Barra de progreso por pasos.
///
/// Representa visualmente un flujo por etapas:
/// - muestra el progreso actual
/// - permite interacción por tap o drag
/// - anima el avance entre pasos
///
/// Casos de uso:
/// - onboarding
/// - formularios multipaso
/// - flujos guiados
///
class ProgressBar extends StatefulWidget {
  /// Paso actual (index).
  final int currentStep;

  /// Labels de cada paso.
  ///
  /// La cantidad de pasos define la estructura
  /// completa de la barra.
  ///
  final List<String> steps;

  /// Callback opcional al interactuar con la barra.
  ///
  /// Devuelve:
  /// - índice del paso seleccionado
  /// - label del paso
  ///
  final void Function(int index, String label)? onStepPress;

  const ProgressBar({
    super.key,
    required this.currentStep,
    required this.steps,
    this.onStepPress,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  /// Controlador de animación del progreso.
  late AnimationController controller;

  /// Animación que controla el ancho del progreso.
  late Animation<double> widthFactor;

  /// Tamaño fijo de los puntos.
  static const double dotSize = 20;

  /// Se guardan las constraints para recalcular
  /// animaciones cuando cambia el step.
  BoxConstraints? _savedConstraints;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Valor inicial del progreso basado en el step actual
    widthFactor = AlwaysStoppedAnimation(
      widget.currentStep / (widget.steps.length - 1),
    );
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si cambia el step, animo suavemente el progreso
    if (oldWidget.currentStep != widget.currentStep &&
        _savedConstraints != null) {
      _animateTo(widget.currentStep, _savedConstraints!);
    }
  }

  /// Anima la barra al paso indicado.
  ///
  /// Convierte el índice de paso en:
  /// - píxeles
  /// - porcentaje del ancho total
  ///
  void _animateTo(int step, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final total = widget.steps.length;

    final fullWidth = width - dotSize;
    final targetPx = (step / (total - 1)) * fullWidth;
    final targetPercent = (targetPx + (dotSize / 2)) / width;

    widthFactor = Tween<double>(
      begin: widthFactor.value,
      end: targetPercent.clamp(0.0, 1.0),
    ).animate(controller);

    controller.forward(from: 0);
  }

  /// Maneja interacción táctil (tap o drag).
  ///
  /// Convierte la posición en pantalla
  /// al step más cercano.
  ///
  void _handleTouch(BoxConstraints constraints, double dx) {
    final width = constraints.maxWidth;
    final total = widget.steps.length;

    final fullWidth = width - dotSize;
    final pos = dx - (dotSize / 2);

    final percent = pos.clamp(0, fullWidth) / fullWidth;
    final step = (percent * (total - 1)).round();

    widget.onStepPress?.call(step, widget.steps[step]);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _savedConstraints = constraints;

        final total = widget.steps.length;
        final width = constraints.maxWidth;
        final fullWidth = width - dotSize;

        // Posición horizontal de cada punto
        final positions = List.generate(
          total,
          (i) => (i / (total - 1)) * fullWidth,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) =>
              _handleTouch(constraints, d.localPosition.dx),
          onHorizontalDragUpdate: (d) =>
              _handleTouch(constraints, d.localPosition.dx),
          child: Column(
            children: [
              // ===== Barra visual =====
              SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    // Barra de fondo
                    Positioned(
                      top: 18,
                      left: positions.first + dotSize / 2,
                      right:
                          (width - (positions.last + dotSize / 2)),
                      child: Container(
                        height: 4,
                        decoration:
                            ProgressBarStyles.backgroundBar(),
                      ),
                    ),

                    // Barra de progreso
                    AnimatedBuilder(
                      animation: controller,
                      builder: (_, __) {
                        final progressWidth =
                            (positions.last - positions.first) *
                            widthFactor.value;

                        return Positioned(
                          top: 18,
                          left:
                              positions.first + dotSize / 2,
                          width: progressWidth,
                          child: Container(
                            height: 4,
                            decoration:
                                ProgressBarStyles.foregroundBar(),
                          ),
                        );
                      },
                    ),

                    // Puntos
                    ...List.generate(total, (i) {
                      final isActive =
                          i <= widget.currentStep;

                      return Positioned(
                        top: 8,
                        left: positions[i],
                        child: Container(
                          width: dotSize,
                          height: dotSize,
                          decoration: isActive
                              ? ProgressBarStyles.circleActive()
                              : ProgressBarStyles
                                  .circleInactive(),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ===== Labels =====
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: List.generate(total, (i) {
                  final isActive =
                      i <= widget.currentStep;

                  return SizedBox(
                    width: 80,
                    child: Center(
                      child: Font(
                        text: widget.steps[i],
                        size: "sm",
                        fontVariant: isActive
                            ? "RobotoBold"
                            : "RobotoRegular",
                        color: isActive
                            ? AppColorKey.secondary
                            : AppColorKey.gray,
                        align: TextAlign.center,
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
