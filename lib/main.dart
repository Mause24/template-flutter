import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:template_flutter/globals/theme/theme.dart';
import 'package:template_flutter/globals/utils/calendar/locale_es_co.dart';
import 'package:template_flutter/routes/general/general_pages.dart';
import 'package:template_flutter/stores/message_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  await initCalendarLocale();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(generalRouterProvider);

    return MaterialApp.router(
      title: 'Project template_flutter',
      locale: const Locale('es', 'CO'),
      supportedLocales: const [Locale('es', 'CO')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        // Capturamos el contexto del MaterialApp que ya contiene el Overlay raíz
        globalMessageContext = context;
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
