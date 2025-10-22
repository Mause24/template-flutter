import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/models/modules/auth_models.dart';
import 'package:template_flutter/stores/auh_store.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authActions = ref.read(authProvider.notifier);

    void onLogin() {
      authActions.login(
        AuthResponse(
          name: "Omar",
          lastname: "Arenas",
          email: "omararenasuni@gmail.com",
        ),
        "token_123",
      );
    }

    void onNavigateRegister() {
      if (context.mounted) {
        context.go("/auth/register");
      }
    }

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      onPressed: onLogin,
                      child: Text("OnLogin"),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      onPressed: onNavigateRegister,
                      child: Text("Navigate To Register"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
