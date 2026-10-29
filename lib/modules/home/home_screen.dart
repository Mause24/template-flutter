import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/stores/auth_store.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authActions = ref.read(authProvider.notifier);

    Future<void> onLogOut() async {
      try {
        await authActions.logout();
        if (context.mounted && !authActions.isAuth()) {
          context.go("/auth");
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Column(
      children: [
        SizedBox(height: 10),
        CustomButton(title: "Log Out", onPressed: onLogOut),
      ],
    );
  }
}
