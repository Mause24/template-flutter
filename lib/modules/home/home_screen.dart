import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/stores/auh_store.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authActions = ref.read(authProvider.notifier);

    void onLogOut() {
      authActions.logout();
    }

    return SafeArea(
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: ElevatedButton(onPressed: onLogOut, child: Text("Log out")),
          ),
        ],
      ),
    );
  }
}
