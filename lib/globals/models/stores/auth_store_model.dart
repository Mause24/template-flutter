import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter/globals/models/globals.dart';
import 'package:template_flutter/globals/models/modules/auth_models.dart';

part 'auth_store_model.g.dart';

@JsonSerializable()
class AuthState extends BaseModel {
  final String? token;
  final UserResponse? user;

  AuthState({this.token, this.user});

  // Método para crear una copia modificada del estado
  AuthState copyWith({String? token, UserResponse? user}) {
    return AuthState(token: token ?? this.token, user: user ?? this.user);
  }

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}
