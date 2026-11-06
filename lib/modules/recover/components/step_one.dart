import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  void onNext() {
    if (context.mounted) {
      context.go("/auth/recover?step=2");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.password_rounded, color: AppColors.primaryDark, size: 100.0),
        Font(
          text: "¿Olvidaste tu contraseña?",
          color: AppColorKey.primaryLight,
          size: "2xl",
          style: TextStyle(fontWeight: FontWeight.bold),
          align: TextAlign.center,
        ),
        Font(
          align: TextAlign.center,
          size: "base",
          color: AppColorKey.blackTransparent,
          style: TextStyle(fontWeight: FontWeight.w600),
          text:
              "Por favor, introduce la dirección asociada; te enviaremos instrucciones para restablecerla.",
        ),
        InputField(
          title: "Correo",
          variant: InputFieldVariant.primary,
          heightField: 50,
          placeholder: "Ingrese el correo electronico",
        ),
        CustomButton(title: "Enviar", onPressed: onNext),
      ],
    );
  }
}
