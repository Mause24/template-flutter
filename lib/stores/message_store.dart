import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/components/message/message.dart';
import 'package:template_flutter/globals/components/custom_modal/custom_modal.dart';
import 'package:template_flutter/globals/components/message/message_styles.dart';

/// ============================================================================
///  CONTEXTO GLOBAL PARA EL OVERLAY
/// ============================================================================
/// Este contexto se asigna desde el `builder` del `MaterialApp` en `main.dart`.
/// Permite acceder al Overlay raíz desde cualquier parte de la app sin necesidad
/// de un BuildContext local.
///
/// El motivo de usar un contexto global es que los Message se montan por encima
/// de toda la UI, asegurando que no queden bloqueados por navegaciones.
/// ============================================================================
BuildContext? globalMessageContext;

/// ============================================================================
///  ESTADO DEL SISTEMA DE MENSAJES
/// ============================================================================
/// Guarda únicamente un OverlayEntry, el cual representa un Message actualmente
/// visible. Si es `null`, no hay mensajes activos.
/// ============================================================================
class MessageState {
  final OverlayEntry? entry;

  const MessageState({this.entry});
}

///
/// Store global que administra el ciclo de vida de los mensajes.
/// Usa Riverpod Notifier para exponer funciones de mostrar y ocultar.
/// Permite desplegar un único mensaje global a la vez.
///
class MessageStore extends Notifier<MessageState> {
  @override
  MessageState build() => const MessageState();

  /// ==========================================================================
  ///  showMessage()
  /// ==========================================================================
  /// Crea un nuevo OverlayEntry y lo inserta en el Overlay raiz.
  /// Asegura:
  ///   • Que siempre exista un solo mensaje activo.
  ///   • Que el mensaje se cierre correctamente desde su propio botón.
  ///   • Que funcione con cualquier tipo de body: String o Widget.
  ///
  /// Parámetros comunes:
  ///   - image: Widget opcional para mostrar en la parte superior.
  ///   - title: String opcional para el encabezado.
  ///   - body: String o Widget (texto o contenido personalizado).
  ///   - buttons: configuración de botones (cancel/confirm).
  ///   - animation: tipo de animación del CustomModal.
  ///   - styles: override de estilos (padding, fondo, sombra, etc.).
  /// ==========================================================================
  void showMessage({
    Widget? image,
    String? title,
    dynamic body, // String o Widget
    required MessageButtons buttons,
    CustomModalAnimation animation = CustomModalAnimation.fade,
    MessageBaseStyles? styles,
  }) {
    final ctx = globalMessageContext;

    // Si el contexto global aún no está listo, no podemos mostrar el mensaje.
    // Esto sucede cuando showMessage() se llama demasiado temprano,
    // antes de que el builder de MyApp haya asignado globalMessageContext.
    if (ctx == null) {
      debugPrint(
        '[MessageStore] globalMessageContext es null. '
        'El builder de MyApp todavía no ha inicializado el contexto global.',
      );
      return;
    }

    // Si ya existe un mensaje visible, removemos el anterior para evitar duplicados.
    state.entry?.remove();

    // Creamos un OverlayEntry, que es un widget flotante que se dibuja
    // por encima de toda la interfaz. Este entry contiene el Message,
    // permitiendo que el mensaje aparezca sobre cualquier pantalla sin
    // importar en qué parte de la app esté el usuario.
    final entry = OverlayEntry(
      builder:
          (_) => Message(
            visible: true,
            image: image,
            title: title,
            body: body,
            buttons: buttons,
            animation: animation,
            styles: styles,
            onClose: hideMessage, // Permite cerrar desde el propio widget.
          ),
    );

    // Obtenemos el Overlay raíz.
    final overlay = Overlay.of(ctx, rootOverlay: true);

    // Insertamos el Message por encima de toda la app.
    overlay.insert(entry);

    // Guardamos la referencia del nuevo Message.
    state = MessageState(entry: entry);
  }

  /// ==========================================================================
  ///  hideMessage()
  /// ==========================================================================
  /// Cierra el mensaje activo eliminando el OverlayEntry,
  /// y limpia el estado para permitir mostrar uno nuevo.
  /// ==========================================================================
  void hideMessage() {
    state.entry?.remove();
    state = const MessageState();
  }
}

/// ============================================================================
///  PROVIDER GLOBAL
/// ============================================================================
/// Se usa desde cualquier parte de la aplicación mediante:
///
///     ref.read(messageStoreProvider.notifier).showMessage(...)
///
/// ============================================================================
final messageStoreProvider = NotifierProvider<MessageStore, MessageState>(
  () => MessageStore(),
);
