import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/api/auth_service.dart';
import 'package:template_flutter/modules/login/models/login_model.dart';
import 'package:template_flutter/stores/auth_store.dart';
import 'package:template_flutter/stores/form_store.dart';

class LoginFormNotifier extends TypedFormNotifier<LoginFormModel> {
  @override
  LoginFormModel get initialModel => LoginFormModel();

  @override
  Map<String, String? Function(LoginFormModel)> get validationSchema => {
    'email':
        (m) =>
            !RegExp(r'\S+@\S+\.\S+').hasMatch(m.email)
                ? 'Debes ingresar un correo valido'
                : null,
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
  };

  // Aquí puedes agregar métodos específicos de este formulario
  Future<bool> submit() async {
    markAllAsTouched();
    if (!validate()) return false;
    state = state.copyWith(isSubmitting: true);
    try {
      // Llamar al servicio de autenticación para iniciar sesión
      final authService = ref.read(authServiceProvider);

      final loginResponse = await authService.login(
        email: state.model.email,
        password: state.model.password,
      );

      // Guardar sesión en AuthStore
      final authNotifier = ref.read(authProvider.notifier);
      await authNotifier.login(loginResponse.user, loginResponse.token);

      return true;
    } on IncorrectPasswordException catch (e) {
      debugPrint("Error: Contraseña incorrecta - ${e.message}");
      return false;
    } on UserNotFoundException catch (e) {
      debugPrint("Error: Usuario no encontrado - ${e.message}");
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

final loginFormProvider =
    NotifierProvider<LoginFormNotifier, FormState<LoginFormModel>>(() {
      return LoginFormNotifier();
    });
