import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:template_flutter/globals/models/modules/auth_models.dart';
import 'package:template_flutter/globals/models/stores/auth_store_model.dart';
import 'package:template_flutter/globals/utils/shared_preferences_instance.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(token: null, user: null)) {
    _loadSessionFromStorage();
  }

  void _loadSessionFromStorage() async {
    final storage = SharedPreferencesInstance();
    final currentSession = await storage.readModel(
      "session",
      AuthState.fromJson,
    );
    if (currentSession != null && currentSession.toJson().isNotEmpty) {
      try {
        state = currentSession;
      } catch (e) {
        // Session is corrupted, keep default state
      }
    }
  }

  Future<void> login(UserResponse user, String token) async {
    final storage = SharedPreferencesInstance();
    (await storage.prefs)?.setString(
      "session",
      jsonEncode({"token": token, "user": user}),
    );

    state = state.copyWith(token: token, user: user);
  }

  bool isAuth() {
    return (state.token != null &&
        state.token!.isNotEmpty &&
        state.user != null);
  }

  Future<void> logout() async {
    final storage = SharedPreferencesInstance();
    (await storage.prefs)?.remove("session");
    state = AuthState(token: null, user: null);
  }
}

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Ref ref) {
    ref.listen(authProvider, (_, __) {
      notifyListeners(); // cada vez que auth cambia, forzamos refresh
    });
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
