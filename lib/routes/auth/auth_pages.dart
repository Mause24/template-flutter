import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/modules/login/login_screen.dart';
import 'package:template_flutter/routes/auth/auth_routes.dart';

final authRouter = [
  ShellRoute(
    builder: (context, state, child) {
      return Scaffold(body: child);
    },
    routes: [
      GoRoute(
        path: AuthRoutes.register,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AuthRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  ),
];
