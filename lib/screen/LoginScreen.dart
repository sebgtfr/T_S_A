import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsa_gram/common/Layout.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/utils.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool chooseForm = true;

  void changeForm() {
    setState(() {
      chooseForm = !chooseForm;
    });
  }

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
            SizedBox(height: 10),
            chooseForm ? SignInForm() : SignUpForm(),
            GestureDetector(
              onTap: () {
                changeForm();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(chooseForm
                      ? "Don't have an Account ? "
                      : "Already have an "
                          "Account ? "),
                  Text(
                    chooseForm ? "Sign Up" : "Sign In",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            SignOut(),
            SizedBox(height: 100),
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
                          SnackBar(content: Text('Deconnected, bye !')))
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
                  if (_formKey.currentState.validate()) {
                    auth
                        .signIn(emailController.text, passwordController.text)
                        .then((value) => {
                              if (value == true)
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: auth.user.displayName != null
                                        ? Text(
                                            'Welcome back ${auth.user.displayName} !')
                                        : Text('Welcome !')))
                            })
                        .catchError((e) {
                      print(e);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    });
                  }
                },
                child: Text('Sign In'),
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
              color: Color(0xFF4C5359), //color of baleine
            )),
        validator: (value) {
          if (value.isEmpty)
            return 'This field must not be empty.';
          else
            return null;
        });
  }
}

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  if (_formKey.currentState.validate()) {
                    auth
                        .signUp(emailController.text, passwordController.text)
                        .then((value) => {
                              if (value == true)
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text('Account created, welcome !')))
                            })
                        .catchError((e) {
                      print(e);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    });
                  }
                },
                child: Text('Sign Up'),
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
              color: Color(0xFF4C5359), //color of baleine
            )),
        validator: (value) {
          if (value.isEmpty)
            return 'This field must not be empty.';
          else
            return null;
        });
  }
}
