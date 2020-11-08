import 'package:flutter/material.dart';
import 'package:tsa_gram/Forms/ForgotForm.dart';

class ForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Forgot password'),
        backgroundColor: const Color(0xFFE0F4FB),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              ForgotForm(),
            ],
          ),
        ),
      ),
    );
  }
}
