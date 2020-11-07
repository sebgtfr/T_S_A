import 'package:flutter/material.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/screen/ForgotScreen.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class SignInForm extends StatefulWidget {
  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            TextInput(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.alternate_email,
              obscured: false,
            ),
            SizedBox(height: 10),
            TextInput(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscured: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotScreen()));
                  },
                  child: Text(
                    'Forgot your password ?',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Button(
              label: 'Sign In',
              onSubmit: () => _auth.signIn(
                  _emailController.text.trim(), _passwordController.text),
              onValidate: () => _formKey.currentState.validate(),
            ),
          ],
        ),
      ),
    );
  }
}
