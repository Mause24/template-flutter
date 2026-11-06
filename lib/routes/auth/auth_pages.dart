import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/layouts/auth_layout/auth_layout.dart';
import 'package:template_flutter/modules/login/login_screen.dart';
import 'package:template_flutter/modules/recover/recover_screen.dart';
import 'package:template_flutter/modules/register/register_screen.dart';
import 'package:template_flutter/routes/auth/auth_routes.dart';

final authRouter = [
  ShellRoute(
    builder: (context, state, child) {
      return Authlayout(state: state, child: child);
    },
    routes: [
      GoRoute(path: AuthRoutes.root, builder: (context, state) => Scaffold()),
      GoRoute(
        path: AuthRoutes.register,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const RegisterScreen(),
            ),
      ),
      GoRoute(
        path: AuthRoutes.login,
        pageBuilder:
            (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        path: AuthRoutes.recover,
        pageBuilder: (context, state) {
          final stepString = state.uri.queryParameters["step"] ?? "1";
          final currentStep = int.tryParse(stepString) ?? 1;
          return NoTransitionPage(
            key: state.pageKey,
            child: RecoverScreen(step: currentStep),
          );
        },
      ),
    ],
  ),
];
