import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    @required this.controller,
    @required this.labelText,
    @required this.obscured,
    @optionalTypeArgs this.icon,
    @optionalTypeArgs this.maxLength,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscured;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscured,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        icon: (icon != null)
            ? Icon(
                icon,
                color: const Color(0xFF4C5359), //color of baleine
              )
            : null,
      ),
      validator: (final String value) {
        if (value.isEmpty)
          return 'This field must not be empty.';
        else
          return null;
      },
    );
  }
}
