// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'globals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ResponseModel<T>(
  data: fromJsonT(json['data']),
  message: json['message'] as String,
);

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'data': toJsonT(instance.data),
  'message': instance.message,
};
