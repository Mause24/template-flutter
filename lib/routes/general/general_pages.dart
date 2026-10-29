import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/splash_screen/splash_screen.dart';
import 'package:template_flutter/routes/auth/auth_pages.dart';
import 'package:template_flutter/routes/general/general_routes.dart';
import 'package:template_flutter/routes/private/private_pages.dart';
import 'package:template_flutter/stores/auth_store.dart';

final generalRouterProvider = Provider<GoRouter>((ref) {
  // Obtengo acciones de autenticación
  final authActions = ref.read(authProvider.notifier);

  return GoRouter(
    // GoRouter recibe la URL directamente del sistema operativo
    redirect: (context, state) async {
      final isSplash = state.matchedLocation == '/splash';
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      if (isSplash) return null;

      if (!authActions.isAuth() && !isAuthRoute) {
        return '/auth';
      }
      if (authActions.isAuth() && isAuthRoute) {
        return '/';
      }

      return null;
    },

    initialLocation: "/splash",
    // Ruta de Splash
    routes: [
      GoRoute(
        path: GeneralRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ...authRouter,
      ...privateRouter,
    ],
  );
});
