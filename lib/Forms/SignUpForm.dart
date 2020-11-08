import 'package:flutter/material.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            TextInput(
              controller: _displayNameController,
              labelText: 'Display name',
              icon: Icons.account_circle,
              obscured: false,
            ),
            const SizedBox(height: 10),
            TextInput(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.alternate_email,
              obscured: false,
            ),
            const SizedBox(height: 10),
            TextInput(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscured: true,
            ),
            const SizedBox(height: 20),
            Button(
              label: 'Sign In',
              onSubmit: () => _auth.signUp(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  _displayNameController.text.trim()),
              onValidate: () => _formKey.currentState.validate(),
            ),
          ],
        ),
      ),
    );
  }
}
