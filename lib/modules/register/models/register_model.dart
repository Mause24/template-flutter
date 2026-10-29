import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter/globals/models/globals.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterFormModel extends BaseModel {
  final String name;
  final String lastName;
  final String email;
  final String companyName;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool termsAndConditions;

  RegisterFormModel({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.companyName = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.termsAndConditions = false,
  });

  // Boilerplate de json_annotation
  factory RegisterFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterFormModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RegisterFormModelToJson(this);

  // Necesitamos un copyWith manual (o usar la librería 'freezed') para actualizar campos
  RegisterFormModel copyWith({
    String? name,
    String? lastName,
    String? email,
    String? companyName,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? termsAndConditions,
  }) {
    return RegisterFormModel(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      companyName: companyName ?? this.companyName,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    );
  }
}
