import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  void onCompleteRecover() {
    if (context.mounted) {
      context.go("/auth/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.lock_reset, color: AppColors.primaryDark, size: 100.0),
        Font(
          text: "Reestablecer contraseña",
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
          text: "Cree una nueva contraseña, diferente a la anterior usada",
        ),
        InputField(
          title: "Contraseña nueva",
          variant: InputFieldVariant.primary,
          heightField: 50,
          placeholder: "Ingrese el codigo de verificacíon",
        ),
        InputField(
          title: "Confirmar contraseña",
          variant: InputFieldVariant.primary,
          heightField: 50,
          placeholder: "Ingrese el codigo de verificacíon",
        ),
        CustomButton(title: "Recuperar", onPressed: onCompleteRecover),
      ],
    );
  }
}
