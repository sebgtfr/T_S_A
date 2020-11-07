import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';

class ProfileScreen extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Column(
      children: <Widget>[
        (user.photoURL != null)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(user.photoURL),
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              )
            : Container(),
        Text('Email: ' + user.email),
        (user.displayName != null)
            ? Text('Display Name: ' + user.displayName)
            : Container(),
        MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color(0xFF4C5359))),
          elevation: 1,
          minWidth: double.maxFinite,
          height: 50,
          color: Color(0xFFE0F4FB),
          onPressed: () {
            _auth.signOut(context);
          },
          child: Text('Logout',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1
                  .copyWith(fontSize: 16)),
        ),
      ],
    );
  }
}
