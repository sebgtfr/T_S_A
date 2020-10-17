import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsa_gram/common/Layout.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<Auth>(
              builder: (BuildContext context, Auth auth, Widget child) =>
                  RaisedButton(
                onPressed: () {
                  auth.signIn("azerty@tsa.com", "azerty");
                },
                child: Text((auth.user != null) ? auth.user.email : 'Login'),
              ),
            ),
            Consumer<Auth>(
              builder: (BuildContext context, Auth auth, Widget child) =>
                  RaisedButton(
                onPressed: () {
                  auth.signOut();
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
