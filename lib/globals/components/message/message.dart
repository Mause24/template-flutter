import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../font/font.dart';
import '../custom_button/custom_button.dart';
import '../custom_modal/custom_modal.dart';
import 'message_styles.dart';

/// Acción individual utilizada por los botones del Message.
///
/// Permite configurar:
/// - texto del botón
/// - variante visual (primary, outline, etc.)
/// - callback a ejecutar
///
class MessageAction {
  final String text;
  final ButtonVariant variant;
  final VoidCallback onPressed;

  MessageAction({
    required this.text,
    required this.variant,
    required this.onPressed,
  });
}

/// Contenedor que agrupa las acciones del Message.
///
/// Ambos botones son opcionales:
/// - cancel: acción secundaria
/// - confirm: acción principal
///
class MessageButtons {
  final MessageAction? cancel;
  final MessageAction? confirm;

  const MessageButtons({this.cancel, this.confirm});
}

///
/// Componente Message global.
///
/// Es una ventana modal reutilizable que se monta
/// por encima de cualquier pantalla usando Overlay.
///
/// Se usa a través de `MessageStore.showMessage()`
/// y no depende de la navegación.
///
/// Casos de uso:
/// - alertas
/// - confirmaciones
/// - mensajes informativos
/// - formularios embebidos
///
class Message extends StatelessWidget {
  /// Controla si el Message está visible o no.
  final bool visible;

  /// Imagen opcional (íconos, ilustraciones, etc.).
  final Widget? image;

  /// Título principal del Message.
  final String? title;

  /// Cuerpo del mensaje.
  ///
  /// Puede ser:
  /// - String (texto simple)
  /// - Widget (contenido complejo: inputs, widgets custom, etc.)
  ///
  final dynamic body;

  /// Configuración de los botones (cancel / confirm).
  final MessageButtons buttons;

  /// Tipo de animación del modal.
  final CustomModalAnimation animation;

  /// Estilos del Message.
  ///
  /// Si es null, se usan los estilos base.
  /// Permite personalización futura sin modificar el componente.
  ///
  final MessageBaseStyles? styles;

  /// Callback que se ejecuta al cerrar el Message.
  ///
  /// El cierre real del overlay lo gestiona MessageStore.
  ///
  final VoidCallback onClose;

  const Message({
    super.key,
    required this.visible,
    required this.onClose,
    required this.buttons,
    this.image,
    this.title,
    this.body,
    this.animation = CustomModalAnimation.fade,
    this.styles,
  });

  @override
  Widget build(BuildContext context) {
    // Si no está visible, no renderiza nada.
    if (!visible) return const SizedBox.shrink();

    final s = styles ?? MessageStyles.base;

    // El Message se renderiza dentro de CustomModal,
    // que controla backdrop y animación.
    return CustomModal(
      isOpen: true,
      dismissible: true,
      animation: animation,
      onClose: onClose,

      // AnimatedPadding ajusta automáticamente cuando
      // el teclado aparece (ej: inputs dentro del Message).
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: MediaQuery.of(context).viewInsets,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 340,
            padding: s.padding,
            decoration: BoxDecoration(
              color: s.background,
              borderRadius: s.borderRadius,
              boxShadow: s.shadow,
            ),

            // Permite scroll si el contenido crece
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== Imagen =====
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: image,
                    ),

                  // ===== Título =====
                  if (title != null)
                    Font(
                      text: title!,
                      size: "xl",
                      fontVariant: "RobotoBold",
                      color: AppColorKey.black,
                      align: TextAlign.center,
                    ),

                  // ===== Body =====
                  if (body != null) ...[
                    const SizedBox(height: 12),
                    _renderBody(),
                  ],

                  const SizedBox(height: 22),

                  // ===== Botones =====
                  _renderButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Renderiza el cuerpo del Message.
  ///
  /// - String → se renderiza como texto centrado
  /// - Widget → se renderiza directamente
  ///
  Widget _renderBody() {
    if (body is String) {
      return Font(
        text: body,
        size: "md",
        fontVariant: "RobotoRegular",
        color: AppColorKey.black,
        align: TextAlign.center,
      );
    }
    return body as Widget;
  }

  /// Renderiza los botones del Message según configuración.
  ///
  /// - Solo confirmación → un botón completo
  /// - Cancel + Confirm → fila con dos botones
  ///
  Widget _renderButtons() {
    final cancel = buttons.cancel;
    final confirm = buttons.confirm;

    // ===== Solo confirmación =====
    if (cancel == null && confirm != null) {
      return CustomButton(
        title: confirm.text,
        variant: confirm.variant,
        onPressed: () {
          confirm.onPressed();
          onClose();
        },
      );
    }

    // ===== Cancelar + Confirmar =====
    return Row(
      children: [
        if (cancel != null)
          Expanded(
            child: CustomButton(
              title: cancel.text,
              variant: cancel.variant,
              onPressed: () {
                cancel.onPressed();
                onClose();
              },
            ),
          ),

        if (cancel != null && confirm != null) const SizedBox(width: 12),

        if (confirm != null)
          Expanded(
            child: CustomButton(
              title: confirm.text,
              variant: confirm.variant,
              onPressed: () {
                confirm.onPressed();
                onClose();
              },
            ),
          ),
      ],
    );
  }
}
