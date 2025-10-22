import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/main_layout/main_layout.dart';
import 'package:template_flutter/modules/home/home_screen.dart';
import 'package:template_flutter/routes/private/private_routes.dart';

final privateRouter = [
  ShellRoute(
    builder: (context, state, child) {
      return MainLayout(child: child);
    },
    routes: [
      GoRoute(
        path: PrivateRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  ),
];
