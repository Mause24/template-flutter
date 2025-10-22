import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:template_flutter/globals/models/modules/auth_models.dart';
import 'package:template_flutter/globals/models/stores/auth_store_model.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState(token: null)) ;

  // Iniciar sesión simulada
  Future<void> login(AuthResponse user, String token) async {
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(token: token, user: user);
  }

  bool isAuth() {
    return (state.token != null &&
        state.token!.isNotEmpty &&
        state.user != null);
  }

  void logout() {
    state = const AuthState(token: null, user: null);
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
