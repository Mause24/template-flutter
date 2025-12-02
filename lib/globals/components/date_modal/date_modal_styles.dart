import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/colors.dart';

/// Estilos visuales del DateModal.
///
/// Centralizo aquí:
/// - colores
/// - bordes
/// - sombras
/// - estilos del calendario
///
class DateModalStyles {
  /// Contenedor principal del modal.
  ///
  /// - fondo blanco
  /// - borde primario
  /// - sombra suave para elevación
  ///
  BoxDecoration get containerDecoration => BoxDecoration(
    color: AppColors.fromKey(AppColorKey.white),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.fromKey(AppColorKey.primary), width: 2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  /// Fondo azul unificado para encabezado.
  ///
  /// Integra visualmente:
  /// - selects
  /// - fila de días de la semana
  ///
  BoxDecoration get headerDecoration => BoxDecoration(
    color: AppColors.fromKey(AppColorKey.primary),
    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
  );

  /// Estilos de las celdas del calendario.
  ///
  /// Mantengo:
  /// - día actual destacado
  /// - día seleccionado con color primario
  /// - coherencia con el tema de la app
  ///
  CalendarStyle get calendarStyle => CalendarStyle(
    outsideDaysVisible: true,
    outsideTextStyle: TextStyle(color: AppColors.fromKey(AppColorKey.gray)),
    weekendTextStyle: const TextStyle(color: Colors.black87),
    defaultTextStyle: const TextStyle(color: Colors.black87),
    todayDecoration: BoxDecoration(
      color: AppColors.fromKey(AppColorKey.secondary).withValues(alpha: 0.6),
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: AppColors.fromKey(AppColorKey.primary),
      shape: BoxShape.circle,
    ),
    todayTextStyle: const TextStyle(color: Colors.white),
    selectedTextStyle: const TextStyle(color: Colors.white),
  );

  /// Estilo de la fila de días de la semana.
  ///
  /// Uso el mismo color del header
  /// para dar continuidad visual.
  ///
  DaysOfWeekStyle get daysOfWeekStyle => DaysOfWeekStyle(
    weekdayStyle: TextStyle(
      color: AppColors.fromKey(AppColorKey.white),
      fontWeight: FontWeight.w700,
    ),
    weekendStyle: TextStyle(
      color: AppColors.fromKey(AppColorKey.white),
      fontWeight: FontWeight.w700,
    ),
    decoration: BoxDecoration(color: AppColors.fromKey(AppColorKey.primary)),
  );
}
