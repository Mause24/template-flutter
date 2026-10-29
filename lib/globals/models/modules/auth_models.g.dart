// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  name: json['name'] as String,
  lastname: json['lastname'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  companyName: json['companyName'] as String,
  avatarImage: json['avatarImage'] as String?,
  profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'companyName': instance.companyName,
      'avatarImage': instance.avatarImage,
      'profile': instance.profile,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) =>
    Profile(id: (json['id'] as num).toInt(), name: json['name'] as String);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String,
      user: UserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};
