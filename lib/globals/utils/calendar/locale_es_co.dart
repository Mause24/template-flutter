import 'package:intl/date_symbol_data_local.dart';

/// Inicializa las configuraciones de idioma español (Colombia)
Future<void> initCalendarLocale() async {
  await initializeDateFormatting('es_CO', null);
}
