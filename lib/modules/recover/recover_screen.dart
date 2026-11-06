import 'package:flutter/material.dart';
import 'package:template_flutter/globals/components/components.dart';
import 'package:template_flutter/modules/recover/components/step_one.dart';
import 'package:template_flutter/modules/recover/components/step_three.dart';
import 'package:template_flutter/modules/recover/components/step_two.dart';

class RecoverScreen extends StatelessWidget {
  final int step;
  const RecoverScreen({super.key, required this.step});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildSteps(context),
    );
  }

  Widget _buildSteps(BuildContext context) {
    switch (step) {
      case 1:
        return StepOne();
      case 2:
        return StepTwo();
      case 3:
        return StepThree();
      default:
        return Font(text: "paso no valido");
    }
  }
}
