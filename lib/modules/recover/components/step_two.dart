import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/globals/theme/colors.dart';

class StepTwo extends StatefulWidget {
  const StepTwo({super.key});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  void onNext() {
    if (context.mounted) {
      context.go("/auth/recover?step=3");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.mail_outline, color: AppColors.primaryDark, size: 100.0),
        Font(
          text: "Revisa tu correo",
          color: AppColorKey.primaryLight,
          size: "3xl",
          style: TextStyle(fontWeight: FontWeight.bold),
          align: TextAlign.center,
        ),
        Font(
          align: TextAlign.center,
          size: "base",
          color: AppColorKey.blackTransparent,
          style: TextStyle(fontWeight: FontWeight.w600),
          text:
              "Enviamos un codigo de verificacion a su correo electronico: example@gmail.com ",
        ),
        InputField(
          title: "Codigo",
          variant: InputFieldVariant.primary,
          heightField: 50,
          placeholder: "Ingrese el codigo de verificacíon",
        ),
        CustomButton(title: "Recuperar", onPressed: onNext),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Font(
              text: "Reenviar codigo",
              onTap: () {
                debugPrint("Se reenvio el codigo");
              },
            ),
          ],
        ),
      ],
    );
  }
}
