import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter/globals/models/globals.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class UserResponse extends BaseModel {
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String companyName;
  final String? avatarImage;
  final Profile profile;

  UserResponse({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.companyName,
    this.avatarImage,
    required this.profile,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class Profile {
  final int id;
  final String name;

  Profile({required this.id, required this.name});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class LoginResponse extends BaseModel {
  final String token;
  final UserResponse user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
