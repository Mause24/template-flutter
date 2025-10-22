import 'package:template_flutter/globals/models/modules/auth_models.dart';

class AuthState {
  final String? token;
  final AuthResponse? user;

  const AuthState({this.token, this.user});

  // Método para crear una copia modificada del estado
  AuthState copyWith({String? token, AuthResponse? user}) {
    return AuthState(token: token ?? this.token, user: user ?? this.user);
  }
}
