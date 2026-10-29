import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';
import 'package:template_flutter/globals/theme/typography.dart';
import 'package:template_flutter/modules/login/providers/login_form_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtain the form state and notifier
    final loginForm = ref.watch(loginFormProvider);
    final notifier = ref.read(loginFormProvider.notifier);

    void onSubmitLogin() async {
      final response = await notifier.submit();
      if (response && context.mounted) {
        context.go("/");
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 30,
        children: [
          Column(
            children: [
              Font(
                text: "Inicio de sesion",
                color: AppColorKey.primaryLight,
                style: AppTypography.textTheme.headlineLarge,
              ),
            ],
          ),
          Column(
            spacing: 10,
            children: [
              InputField(
                heightField: 50,
                title: "Email",
                placeholder: "Ingresa tu correo electronico",
                keyboardType: TextInputType.emailAddress,
                error:
                    loginForm.touchedFields.contains("email")
                        ? loginForm.errors['email']
                        : null,
                onBlur: () => notifier.markAsTouched('email'),
                onChange:
                    (val) =>
                        notifier.updateModel((m) => m.copyWith(email: val)),
              ),
              InputField(
                heightField: 50,
                title: "Contraseña",
                obscureText: true,
                placeholder: "Ingresa tu contraseña",
                keyboardType: TextInputType.text,
                error:
                    loginForm.touchedFields.contains("password")
                        ? loginForm.errors['password']
                        : null,
                onBlur: () => notifier.markAsTouched('password'),
                onChange:
                    (val) =>
                        notifier.updateModel((m) => m.copyWith(password: val)),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Font(
                text: "¿Olvidaste tu contraseña?",
                onTap: () {
                  debugPrint("Olvidar contraseña");
                },
                color: AppColorKey.primaryLight,
                size: "sm",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),

          CustomButton(
            title: "Iniciar Sesion",
            isLoading: loginForm.isSubmitting,
            disabled: loginForm.isSubmitting || !loginForm.isValid,
            onPressed: onSubmitLogin,
          ),

          Font.rich(
            children: [
              TextSpan(text: "¿Aun no te has registrado? "),
              TextSpan(
                text: "Unete!",
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.bold,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        if (context.mounted) {
                          context.go("/auth/register");
                        }
                      },
              ),
            ],
            color: AppColorKey.black,
            size: "sm",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
