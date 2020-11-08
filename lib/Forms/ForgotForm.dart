import 'package:flutter/material.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/widgets/TextInput.dart';
import 'package:tsa_gram/widgets/Button.dart';

class ForgotForm extends StatefulWidget {
  @override
  ForgotFormState createState() {
    return ForgotFormState();
  }
}

class ForgotFormState extends State<ForgotForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            TextInput(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.alternate_email,
              obscured: false,
            ),
            const SizedBox(height: 10),
            Button(
              onSubmit: () =>
                  _auth.forgot(_emailController.text).then<void>((void dummy) {
                Scaffold.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email send !'),
                  ),
                );
              }),
              onValidate: () => _formKey.currentState.validate(),
            ),
          ],
        ),
      ),
    );
  }
}
