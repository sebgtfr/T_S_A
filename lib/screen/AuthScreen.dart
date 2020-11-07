import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/Forms/SignInForm.dart';
import 'package:tsa_gram/Forms/SignUpForm.dart';
import 'package:tsa_gram/utils.dart';

// final TextEditingController emailForgotController = TextEditingController();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool chooseForm = true;

  void changeForm() {
    setState(() {
      chooseForm = !chooseForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
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
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/img/logo.jpg'),
                            width: 250,
                          ),
                          Text('TSA_Gram',
                              style:
                                  kTextStyleYellowMoon.copyWith(fontSize: 50)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              chooseForm ? SignInForm() : SignUpForm(),
              SizedBox(height: 20),
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
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
