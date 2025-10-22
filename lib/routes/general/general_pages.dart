import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/splash_screen/splash_screen.dart';
import 'package:template_flutter/routes/auth/auth_pages.dart';
import 'package:template_flutter/routes/general/general_routes.dart';
import 'package:template_flutter/routes/private/private_pages.dart';
import 'package:template_flutter/stores/auh_store.dart';

final generalRouterProvider = Provider<GoRouter>((ref) {
  final authActions = ref.read(authProvider.notifier);

  return GoRouter(
    redirect: (context, state) async {
      final isSplash = state.matchedLocation == '/splash';
      final isAuthRoute = state.matchedLocation.startsWith('/auth/');

      if (isSplash) return null;

      if (!authActions.isAuth() && !isAuthRoute) {
        return '/auth/login';
      }

      if (authActions.isAuth() && isAuthRoute) {
        return '/';
      }

      return null;
    },
    initialLocation: "/splash",
    refreshListenable: GoRouterRefreshNotifier(ref),
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
