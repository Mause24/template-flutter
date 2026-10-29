// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFormModel _$LoginFormModelFromJson(Map<String, dynamic> json) =>
    LoginFormModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$LoginFormModelToJson(LoginFormModel instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};
