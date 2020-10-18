import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsa_gram/common/Layout.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/utils.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Color(0xFFE0F4FB),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/img/logo.jpg'),
                          width: 250,
                        ),
                        Text('TSA_Gram',
                            style: kTextStyleYellowMoon.copyWith(fontSize: 50)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SignInForm(),
            SignOut(),
            SizedBox(height: 300),
            Consumer<Auth>(
              builder: (BuildContext context, Auth auth, Widget child) =>
                  Text((auth.user != null)
                      ? 'User: ' + auth.user.email
                      : 'Not '
                          'logged'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (BuildContext context, Auth auth, Widget child) => RaisedButton(
        onPressed: () {
          auth
              .signOut()
              .then((value) => {
                    if (value == null)
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Deconnected !')))
                  })
              .catchError((e) {
            print(e);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          });
        },
        child: Text('Logout'),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            _buildTextField(
                emailController, 'Email', Icons.account_circle, false),
            SizedBox(height: 10),
            _buildTextField(passwordController, 'Password', Icons.lock, true),
            SizedBox(height: 10),
            Consumer<Auth>(
              builder: (BuildContext context, Auth auth, Widget child) =>
                  RaisedButton(
                onPressed: () {
                  print(_formKey);
                  if (_formKey.currentState.validate()) {
                    auth
                        .signIn(emailController.text, passwordController.text)
                        .then((value) => {
                              if (value == true)
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Connexion '
                                        'réussi !')))
                            })
                        .catchError((e) {
                      print(e);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    });
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTextField(TextEditingController controller, String labelText,
      IconData icon, bool obscured) {
    return TextFormField(
        controller: controller,
        obscureText: obscured,
        decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            icon: Icon(
              icon,
              color: Colors.blueGrey,
            )),
        validator: (value) {
          if (value.isEmpty)
            return 'This field must not be empty.';
          else
            return null;
        });
  }
}
