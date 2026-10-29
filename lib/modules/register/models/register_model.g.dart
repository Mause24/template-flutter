// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFormModel _$RegisterFormModelFromJson(Map<String, dynamic> json) =>
    RegisterFormModel(
      name: json['name'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      password: json['password'] as String? ?? '',
      confirmPassword: json['confirmPassword'] as String? ?? '',
      termsAndConditions: json['termsAndConditions'] as bool? ?? false,
    );

Map<String, dynamic> _$RegisterFormModelToJson(RegisterFormModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'email': instance.email,
      'companyName': instance.companyName,
      'phone': instance.phone,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'termsAndConditions': instance.termsAndConditions,
    };
