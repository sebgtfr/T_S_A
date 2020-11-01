import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {@required TextEditingController this.controller,
      @required String this.labelText,
      @required IconData this.icon,
      @required bool this.obscured});

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscured;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscured,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(
          icon,
          color: Color(0xFF4C5359), //color of baleine
        ),
      ),
      validator: (value) {
        if (value.isEmpty)
          return 'This field must not be empty.';
        else
          return null;
      },
    );
  }
}
