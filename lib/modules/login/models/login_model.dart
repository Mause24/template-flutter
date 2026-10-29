import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter/globals/models/globals.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginFormModel extends BaseModel {
  final String email;
  final String password;

  LoginFormModel({this.email = '', this.password = ''});

  // Boilerplate de json_annotation
  factory LoginFormModel.fromJson(Map<String, dynamic> json) =>
      _$LoginFormModelFromJson(json);

  LoginFormModel copyWith({String? email, String? password}) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, dynamic> toJson() => _$LoginFormModelToJson(this);
}
