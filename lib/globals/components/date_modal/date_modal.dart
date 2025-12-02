import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../custom_button/custom_button.dart';
import '../select_field/select_field.dart';
import '../select_field/select_field_styles.dart';
import 'date_modal_styles.dart';
import '../../theme/colors.dart';

/// Modal de selección de fecha.
///
/// Este modal se encarga de:
/// - renderizar un calendario completo
/// - permitir cambiar mes y año mediante selects
/// - manejar la fecha seleccionada internamente
/// - devolver la fecha confirmada al componente padre
///
class DateModal extends StatefulWidget {
  /// Fecha inicial del calendario.
  /// Si es null, se posiciona en la fecha actual.
  final DateTime? initialDate;

  /// Callback que devuelve la fecha seleccionada
  /// cuando el usuario confirma.
  final void Function(DateTime) onConfirm;

  /// Callback que se ejecuta al cancelar.
  final VoidCallback onCancel;

  const DateModal({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.initialDate,
  });

  @override
  State<DateModal> createState() => _DateModalState();
}

class _DateModalState extends State<DateModal> {
  /// Día actualmente enfocado por el calendario.
  late DateTime _focused;

  /// Día seleccionado por el usuario.
  /// Puede ser null hasta que elija una fecha.
  DateTime? _selected;

  /// Opciones de años para el selector.
  late final List<SelectItemOption<int>> _years;

  /// Opciones de meses para el selector.
  late final List<SelectItemOption<int>> _months;

  /// Mapeo entre número de mes y nombres.
  ///
  /// - short: abreviatura para el select
  /// - full: nombre completo para el dropdown
  ///
  final Map<int, Map<String, String>> _monthNames = {
    1: {"short": "Ene", "full": "Enero"},
    2: {"short": "Feb", "full": "Febrero"},
    3: {"short": "Mar", "full": "Marzo"},
    4: {"short": "Abr", "full": "Abril"},
    5: {"short": "May", "full": "Mayo"},
    6: {"short": "Jun", "full": "Junio"},
    7: {"short": "Jul", "full": "Julio"},
    8: {"short": "Ago", "full": "Agosto"},
    9: {"short": "Sep", "full": "Septiembre"},
    10: {"short": "Oct", "full": "Octubre"},
    11: {"short": "Nov", "full": "Noviembre"},
    12: {"short": "Dic", "full": "Diciembre"},
  };

  @override
  void initState() {
    super.initState();

    // Corrige desfase de día por UTC.
    // Evito que se seleccione "mañana" por diferencias de zona horaria.
    final now = DateTime.now();
    final localNow = DateTime(now.year, now.month, now.day);

    // Fecha foco inicial
    _focused = widget.initialDate ?? localNow;
    _selected = widget.initialDate;

    // Generación de años (150 hacia atrás)
    final currentYear = localNow.year;
    _years = List.generate(
      151,
      (i) => SelectItemOption(
        label: (currentYear - i).toString(),
        value: currentYear - i,
      ),
    );

    // Generación de meses
    _months = List.generate(
      12,
      (i) =>
          SelectItemOption(label: _monthNames[i + 1]!["short"]!, value: i + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = DateModalStyles();

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(12),
        decoration: s.containerDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // === Header ===
            // Contiene select de mes y año con fondo unificado
            Container(
              decoration: s.headerDecoration,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
                    child: Row(
                      children: [
                        // ===== Select de Mes =====
                        Expanded(
                          child: SelectField<int>(
                            options: _months,
                            value: _months.firstWhere(
                              (m) => m.value == _focused.month,
                              orElse: () => _months.first,
                            ),
                            onChange: (opt) {
                              setState(() {
                                _focused = DateTime(
                                  _focused.year,
                                  opt.value,
                                  1,
                                );
                              });
                            },
                            placeholder: "Mes",
                            variant: SelectFieldVariant.primary,

                            /// Personalización visual del dropdown
                            itemBuilder: (onTap, item) {
                              final isSelected = item.value == _focused.month;

                              return InkWell(
                                onTap: onTap,
                                child: Container(
                                  color:
                                      isSelected
                                          ? AppColors.fromKey(
                                            AppColorKey.primary,
                                          ).withValues(alpha: 0.9)
                                          : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    _monthNames[item.value]!["full"]!,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                            customStyles: SelectFieldStyles.of(
                              SelectFieldVariant.primary,
                              inverted: true,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ===== Select de Año =====
                        Expanded(
                          child: SelectField<int>(
                            options: _years,
                            value: _years.firstWhere(
                              (y) => y.value == _focused.year,
                              orElse: () => _years.first,
                            ),
                            onChange: (opt) {
                              setState(() {
                                _focused = DateTime(
                                  opt.value,
                                  _focused.month,
                                  1,
                                );
                              });
                            },
                            placeholder: "Año",
                            variant: SelectFieldVariant.primary,
                            itemBuilder: (onTap, item) {
                              final isSelected = item.value == _focused.year;

                              return InkWell(
                                onTap: onTap,
                                child: Container(
                                  color:
                                      isSelected
                                          ? AppColors.fromKey(
                                            AppColorKey.primary,
                                          ).withValues(alpha: 0.9)
                                          : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                            customStyles: SelectFieldStyles.of(
                              SelectFieldVariant.primary,
                              inverted: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2),
                ],
              ),
            ),

            // === Calendario ===
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.fromKey(AppColorKey.primary),
                  width: 1.5,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
                child: TableCalendar(
                  locale: 'es_CO',
                  firstDay: DateTime(1900, 1, 1),
                  lastDay: DateTime(2100, 12, 31),
                  focusedDay: _focused,
                  selectedDayPredicate:
                      (day) => _selected != null && isSameDay(_selected, day),
                  onDaySelected: (day, focus) {
                    setState(() {
                      _selected = day;
                      _focused = focus;
                    });
                  },
                  headerVisible: false,
                  calendarStyle: s.calendarStyle,
                  daysOfWeekStyle: s.daysOfWeekStyle,
                  daysOfWeekHeight: 28,
                  rowHeight: 42,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // === Botones ===
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: CustomButton(
                      title: "Cancelar",
                      variant: ButtonVariant.outline,
                      onPressed: widget.onCancel,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: CustomButton(
                      title: "Aceptar",
                      variant: ButtonVariant.primary,
                      onPressed: () {
                        if (_selected != null) {
                          widget.onConfirm(_selected!);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
