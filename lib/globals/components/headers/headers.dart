import 'package:flutter/material.dart';
import '../font/font.dart';
import 'headers_styles.dart';
import '../../theme/colors.dart';

/// Variantes soportadas por el Header.
///
/// - base: header principal con fondo y opcional botón atrás
/// - menu: header simple usado en secciones internas
///
enum HeaderVariant { base, menu }

/// Header reutilizable de la app.
///
/// Este componente lo uso para:
/// - encabezados principales de pantallas
/// - encabezados simples de menús o secciones
///
/// El comportamiento y el layout dependen
/// de la variante seleccionada.
///
class Header extends StatelessWidget {
  /// Variante visual del header.
  final HeaderVariant variant;

  /// Texto principal del encabezado.
  final String title;

  /// Indica si se muestra el botón de "volver".
  ///
  /// Solo aplica a la variante `base`.
  ///
  final bool back;

  const Header({
    super.key,
    this.variant = HeaderVariant.base,
    required this.title,
    this.back = false,
  });

  @override
  Widget build(BuildContext context) {
    final styles = HeaderStyles.base;

    // =================================================
    // MENU HEADER
    // =================================================
    //
    // Variante liviana sin fondo ni botón atrás.
    // Normalmente la uso dentro de pantallas
    // de configuración o secciones internas.
    //
    if (variant == HeaderVariant.menu) {
      return Container(
        padding: styles.menuPadding,
        child: Font(
          text: title,
          size: "xl",
          fontVariant: "RobotoBold",
          color: AppColorKey.black,
        ),
      );
    }

    // =================================================
    // BASE HEADER
    // =================================================
    //
    // Header principal de pantalla.
    // - altura fija
    // - fondo primario
    // - título en blanco
    // - botón atrás opcional
    //
    return Container(
      height: styles.height,
      padding: styles.basePadding,
      decoration: BoxDecoration(
        color: AppColors.fromKey(styles.backgroundColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ===== Back Arrow =====
          // Solo se renderiza si está habilitado.
          if (back)
            GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: styles.backPadding,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.fromKey(styles.iconColor),
                  size: 28,
                ),
              ),
            ),

          // ===== Title =====
          Font(
            text: title,
            size: "xl",
            fontVariant: "RobotoBold",
            color: AppColorKey.white,
          ),
        ],
      ),
    );
  }
}
