// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
  token: json['token'] as String?,
  user: json['user'] == null
      ? null
      : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
  'token': instance.token,
  'user': instance.user,
};
