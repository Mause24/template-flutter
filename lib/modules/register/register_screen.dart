import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';
import 'package:template_flutter/globals/theme/typography.dart';
import 'package:template_flutter/modules/register/providers/register_form_provider.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    final notifier = ref.watch(registerFormProvider.notifier);

    void onSubmitRegister() async {
      final response = await notifier.submit();
      if (response && context.mounted) {
        context.go("/auth/login");
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 80,
        ),
        child: Column(
          spacing: 10,
          children: [
            Column(
              children: [
                Font(
                  text: "Crea tu cuenta",
                  color: AppColorKey.primaryLight,
                  style: AppTypography.textTheme.headlineLarge,
                ),
              ],
            ),
            InputField(
              heightField: 50,
              title: "Nombres",
              placeholder: "Ingresa tus nombres",
              keyboardType: TextInputType.name,
              error:
                  registerForm.touchedFields.contains("name")
                      ? registerForm.errors['name']
                      : null,
              onBlur: () => notifier.markAsTouched('name'),
              onChange:
                  (val) => notifier.updateModel((m) => m.copyWith(name: val)),
            ),

            InputField(
              heightField: 50,
              title: "Apellidos",
              placeholder: "Ingresa tus apellidos",
              keyboardType: TextInputType.name,
              error:
                  registerForm.touchedFields.contains("lastName")
                      ? registerForm.errors['lastName']
                      : null,
              onBlur: () => notifier.markAsTouched('lastName'),
              onChange:
                  (val) =>
                      notifier.updateModel((m) => m.copyWith(lastName: val)),
            ),

            InputField(
              heightField: 50,
              title: "Email",
              placeholder: "Ingresa tu correo electronico",
              keyboardType: TextInputType.emailAddress,
              error:
                  registerForm.touchedFields.contains("email")
                      ? registerForm.errors['email']
                      : null,
              onBlur: () => notifier.markAsTouched('email'),
              onChange:
                  (val) => notifier.updateModel((m) => m.copyWith(email: val)),
            ),

            InputField(
              heightField: 50,
              title: "Nombre del negocio",
              placeholder: "Ingresa el nombre de tu negocio",
              keyboardType: TextInputType.text,
              error:
                  registerForm.touchedFields.contains("companyName")
                      ? registerForm.errors['companyName']
                      : null,
              onBlur: () => notifier.markAsTouched('companyName'),
              onChange:
                  (val) =>
                      notifier.updateModel((m) => m.copyWith(companyName: val)),
            ),

            PhoneField(
              heightField: 50,
              title: "Teléfono",
              placeholder: "Ingresa tu numero de telefono",
              error:
                  registerForm.touchedFields.contains("phone")
                      ? registerForm.errors['phone']
                      : null,
              onBlur: () => notifier.markAsTouched('phone'),
              onChange:
                  (fullValue) =>
                      notifier.updateModel((m) => m.copyWith(phone: fullValue)),
            ),

            InputField(
              heightField: 50,
              title: "Contraseña",
              obscureText: true,
              placeholder: "Ingresa tu contraseña",
              keyboardType: TextInputType.text,
              error:
                  registerForm.touchedFields.contains("password")
                      ? registerForm.errors['password']
                      : null,
              onBlur: () => notifier.markAsTouched('password'),
              onChange:
                  (val) =>
                      notifier.updateModel((m) => m.copyWith(password: val)),
            ),

            InputField(
              heightField: 50,
              title: "Confirmar contraseña",
              obscureText: true,
              placeholder: "Escribe nuevamente tu contraseña",
              keyboardType: TextInputType.text,
              error:
                  registerForm.touchedFields.contains("confirmPassword")
                      ? registerForm.errors['confirmPassword']
                      : null,
              onBlur: () => notifier.markAsTouched('confirmPassword'),
              onChange:
                  (val) => notifier.updateModel(
                    (m) => m.copyWith(confirmPassword: val),
                  ),
            ),

            CheckBox(
              checked: registerForm.model.termsAndConditions,
              error:
                  registerForm.touchedFields.contains("termsAndConditions")
                      ? registerForm.errors['termsAndConditions']
                      : null,
              onChange:
                  (val) => notifier.updateModel(
                    (m) => m.copyWith(termsAndConditions: val),
                  ),
              child: Font.rich(
                children: [
                  TextSpan(text: 'Estoy de acuerdo con los '),
                  TextSpan(
                    text: 'Terminos y condiciones ',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("Terminos y condiciones");
                          },
                  ),
                  TextSpan(text: 'y '),
                  TextSpan(
                    text: 'Las politicas de privacidad ',
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("politicas de privacidad");
                          },
                  ),
                ],
                color: AppColorKey.black,
                maxLines: 2,
                size: "sm",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),

            CustomButton(
              title: "Crear cuenta",
              isLoading: registerForm.isSubmitting,
              disabled: registerForm.isSubmitting || !registerForm.isValid,
              onPressed: onSubmitRegister,
            ),

            Font.rich(
              children: [
                TextSpan(text: "¿Ya tienes una cuenta? "),
                TextSpan(
                  text: "Inicia sesion",
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          context.go("/auth/login");
                        },
                ),
              ],
              color: AppColorKey.black,
              size: "sm",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
