import 'package:flutter/widgets.dart' hide FormState;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/api/auth_service.dart';
import 'package:template_flutter/modules/register/models/register_model.dart';
import 'package:template_flutter/stores/form_store.dart';

class RegisterFormNotifier extends TypedFormNotifier<RegisterFormModel> {
  @override
  RegisterFormModel get initialModel => RegisterFormModel();

  @override
  Map<String, String? Function(RegisterFormModel)> get validationSchema => {
    'name': (m) => m.name.isEmpty ? 'Debes ingresar el nombre' : null,
    'lastName': (m) => m.lastName.isEmpty ? 'Debes ingresar el apellido' : null,
    'email':
        (m) =>
            !RegExp(r'\S+@\S+\.\S+').hasMatch(m.email)
                ? 'Debes ingresar un correo valido'
                : null,
    'companyName':
        (m) =>
            m.companyName.isEmpty
                ? 'Debes ingresar el nombre de la empresa'
                : null,
    'phone': (m) => m.phone.isEmpty ? 'Debes ingresar el telefono' : null,
    'password':
        (m) => switch (m.password) {
          _ when m.password.isEmpty => 'Debes ingresar la contraseña',
          _ when m.password.length < 6 =>
            'La contraseña debe tener al menos 6 caracteres',
          _ when !RegExp(r'[A-Z]').hasMatch(m.password) =>
            'Debe contener al menos una mayúscula',
          _ when !RegExp(r'[0-9]').hasMatch(m.password) =>
            'Debe contener al menos un número',
          _ when !RegExp(r'[!@#\$&*~]').hasMatch(m.password) =>
            'Debe contener al menos un caracter especial',

          _ => null,
        },
    'confirmPassword':
        (m) => switch (m.confirmPassword) {
          _ when m.confirmPassword.isEmpty => 'Debes confirmar la contraseña',
          _ when m.confirmPassword != m.password => "La contraseña no coincide",
          _ => null,
        },
    'termsAndConditions':
        (m) =>
            !m.termsAndConditions ? 'Acepta los terminos y condiciones' : null,
  };

  // Aquí puedes agregar métodos específicos de este formulario
  Future<bool> submit() async {
    markAllAsTouched();
    if (!validate()) return false;
    state = state.copyWith(isSubmitting: true);
    try {
      // Llamar al servicio de autenticación para registrar el usuario
      final authService = ref.read(authServiceProvider);

      final response = await authService.register(
        name: state.model.name,
        lastname: state.model.lastName,
        email: state.model.email,
        password: state.model.password,
        phone: state.model.phone,
        companyName: state.model.companyName,
      );

      return response;
    } on EmailAlreadyExistsException catch (e) {
      debugPrint("Error: Email ya existe - ${e.message}");
      return false;
    } on ServerException catch (e) {
      debugPrint("Error: Error del servidor - ${e.message}");
      return false;
    } catch (e) {
      debugPrint("Error inesperado: $e");
      return false;
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }
}

final registerFormProvider =
    NotifierProvider<RegisterFormNotifier, FormState<RegisterFormModel>>(() {
      return RegisterFormNotifier();
    });
