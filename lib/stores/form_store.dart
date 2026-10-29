import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/models/globals.dart';

class FormState<T extends BaseModel> {
  final T model;
  final Map<String, String?> errors;
  final Set<String> touchedFields;
  final bool isValid;
  final bool isSubmitting;

  FormState({
    required this.model,
    this.errors = const {},
    this.isSubmitting = false,
    this.isValid = true,
    this.touchedFields = const {},
  });

  FormState<T> copyWith({
    T? model,
    Map<String, String?>? errors,
    bool? isSubmitting,
    bool? isValid,
    Set<String>? touchedFields,
  }) {
    return FormState<T>(
      model: model ?? this.model,
      errors: errors ?? this.errors,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isValid: isValid ?? this.isValid,
      touchedFields: touchedFields ?? this.touchedFields,
    );
  }
}

// Esta es la lógica base. No lleva @riverpod porque es genérica.
abstract class TypedFormNotifier<T extends BaseModel>
    extends Notifier<FormState<T>> {
  Map<String, String? Function(T)> get validationSchema;
  T get initialModel;

  @override
  FormState<T> build() {
    return FormState(model: initialModel);
  }

  void updateModel(T Function(T) update) {
    final newModel = update(state.model);
    final newErrors = <String, String?>{};
    validationSchema.forEach((key, validator) {
      final validationResult = validator(newModel);
      if (validationResult == null) return;
      newErrors[key] = validationResult;
    });
    state = state.copyWith(
      model: newModel,
      errors: newErrors,
      isValid: newErrors.isEmpty,
    );
  }

  void markAsTouched(String fieldName) {
    state = state.copyWith(touchedFields: {...state.touchedFields, fieldName});
  }

  void markAllAsTouched() {
    state = state.copyWith(touchedFields: {...state.model.toJson().keys});
  }

  bool validate() {
    final newErrors = <String, String?>{};
    bool isValid = true;
    validationSchema.forEach((key, validator) {
      final error = validator(state.model);
      newErrors[key] = error;
      if (error != null) isValid = false;
    });
    state = state.copyWith(errors: newErrors, isValid: isValid);
    return isValid;
  }
}
