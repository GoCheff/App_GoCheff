import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextEditingController? controller;
  final String name;
  final String labelText;
  final bool isSecret;
  final TextInputType inputType;
  final List<Function>? additionalValidators;

  TextInput({
    Key? key,
    required this.name,
    required this.labelText,
    required this.controller,
    this.isSecret = false,
    this.inputType = TextInputType.text,
    this.additionalValidators,
  }) : super(key: key);

  String? validator(String field, String? value,
      [List<Function>? additionalValidators]) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }

    if (additionalValidators == null) {
      return null;
    }

    String? additionalError;

    for (var validator in additionalValidators) {
      final error = validator(value);

      if (error != null) {
        additionalError = error;
        break;
      }
    }

    if (additionalError != null) {
      return additionalError;
    }

    return null;
  }

  bool isFocused(context) {
    return FocusScope.of(context).hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isSecret,
      enableSuggestions: !isSecret,
      autocorrect: !isSecret,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: (value) => validator(name, value, additionalValidators),
      onSaved: (value) => controller?.text = value ?? '',
    );
  }
}
