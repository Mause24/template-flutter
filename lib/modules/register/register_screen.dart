import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onNavigateLogin() {
      if (context.mounted) {
        context.go("/auth/login");
      }
    }

    return SafeArea(
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: ElevatedButton(
              onPressed: onNavigateLogin,
              child: Text("Navigate To Login"),
            ),
          ),
        ],
      ),
    );
  }
}
