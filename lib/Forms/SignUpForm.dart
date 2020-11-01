import 'package:flutter/material.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
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
              icon: Icons.account_circle,
              obscured: false,
            ),
            SizedBox(height: 10),
            TextInput(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              obscured: true,
            ),
            SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Color(0xFF4C5359))),
              elevation: 1,
              minWidth: double.maxFinite,
              height: 50,
              color: Color(0xFFE0F4FB),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _auth
                      .signUp(_emailController.text, _passwordController.text)
                      .catchError((e) {
                    print(e);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(e.message),
                      backgroundColor: Colors.redAccent,
                    ));
                  });
                }
              },
              child: Text('Sign Up',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1
                      .copyWith(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
