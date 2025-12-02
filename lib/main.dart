import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:template_flutter/globals/utils/calendar/locale_es_co.dart';
import 'package:template_flutter/routes/general/general_pages.dart';
import 'package:template_flutter/stores/message_store.dart';

void main() async {
  // Asegura de que Flutter esté inicializado antes de cargar locales o providers.
  WidgetsFlutterBinding.ensureInitialized();

  // Activo la localización personalizada para TableCalendar.
  await initCalendarLocale();

  // Envolví toda la app en ProviderScope para poder usar Riverpod en cualquier parte.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Router central (maneja deep links automáticamente)
    final router = ref.watch(generalRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Template Flutter',

      // Configuración de idioma por defecto
      locale: const Locale('es', 'CO'),
      supportedLocales: const [Locale('es', 'CO')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // GoRouter maneja navegación + deep links
      routerConfig: router,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      // ====================================================
      // Overlay global (NO afecta deep linking)
      // ====================================================
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (ctx) {
                globalMessageContext = ctx;
                return child ?? const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
