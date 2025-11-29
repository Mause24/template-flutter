import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/splash_screen/splash_screen.dart';
import 'package:template_flutter/routes/auth/auth_pages.dart';
import 'package:template_flutter/routes/general/general_routes.dart';
import 'package:template_flutter/routes/private/private_pages.dart';
import 'package:template_flutter/stores/auh_store.dart';
import 'package:template_flutter/modules/component_view/component_view.dart';
import 'package:template_flutter/modules/deep_link/deep_link_page.dart';

final generalRouterProvider = Provider<GoRouter>((ref) {
  // Obtengo acciones de autenticación
  final authActions = ref.read(authProvider.notifier);

  return GoRouter(
    // GoRouter recibe la URL directamente del sistema operativo
    redirect: (context, state) async {
      final isSplash = state.matchedLocation == '/splash';
      final isAuthRoute = state.matchedLocation.startsWith('/auth/');
      final isComponentView = state.matchedLocation == '/component-view';
      final isDeepLink = state.matchedLocation.startsWith('/open/');

      if (isSplash) return null;

      // Permitir vista de componentes sin login
      if (isComponentView) return null;

      // Permitir deep links sin login
      if (isDeepLink) return null;

      if (!authActions.isAuth() && !isAuthRoute) {
        return '/auth/login';
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

      // Ruta de vista de componente agregada
      GoRoute(
        path: GeneralRoutes.componentView,
        builder: (context, state) => const ComponentViewScreen(),
      ),

      // ======================================
      //          RUTA DEEP LINKING
      // Ejemplo: https://templateflutter.com/open/ABC123
      // ======================================
      GoRoute(
        path: GeneralRoutes.deepLinkPattern,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DeepLinkPage(id: id);
        },
      ),

      ...authRouter,
      ...privateRouter,
    ],
  );
});
