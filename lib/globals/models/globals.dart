import 'package:json_annotation/json_annotation.dart';

part "globals.g.dart";

abstract class BaseModel {
  Map<String, dynamic> toJson();
}

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  final T data;
  final String message;

  ResponseModel({required this.data, required this.message});
  // El método de fábrica debe recibir una función para mapear 'T'
  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ResponseModelFromJson(json, fromJsonT);

  // El método toJson también debe recibir una función para mapear 'T'
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);
}

typedef FromJsonFactory<T extends BaseModel> =
    T Function(Map<String, dynamic> json);
