import 'package:go_router/go_router.dart';
import 'package:template_flutter/routes/general/general_routes.dart';
import 'package:template_flutter/screens/home/home_screen.dart';
import 'package:template_flutter/shared/splash_screen.dart';

final GoRouter generalRouter = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: GeneralRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: GeneralRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
