import 'package:flutter/material.dart';

class ValueTextField extends StatelessWidget {
  const ValueTextField({
    super.key,
    required this.controller,
    required this.amountValueInCents,
    required this.errorMessage,
  });

  final TextEditingController controller;
  final int amountValueInCents;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final amountFormula = controller.text.trim();
    final amountValue = (amountValueInCents / 100).toStringAsFixed(2);
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorText: errorMessage,
        errorMaxLines: 3,
        prefixIcon: const Icon(Icons.euro),
        helperText: amountFormula != amountValue ? amountValue : null,
        helperStyle: const TextStyle(fontSize: 24),
      ),
      style: const TextStyle(fontSize: 35),
    );
  }
}
