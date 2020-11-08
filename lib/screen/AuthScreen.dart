import 'package:flutter/material.dart';

import 'package:tsa_gram/Forms/SignInForm.dart';
import 'package:tsa_gram/Forms/SignUpForm.dart';
import 'package:tsa_gram/utils.dart';

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
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          color: Color(0xFFE0F4FB),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(90))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Image(
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
              const SizedBox(height: 10),
              if (chooseForm) SignInForm() else SignUpForm(),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  changeForm();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(chooseForm
                        ? "Don't have an Account ? "
                        : 'Already have an '
                            'Account ? '),
                    Text(
                      chooseForm ? 'Sign Up' : 'Sign In',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
