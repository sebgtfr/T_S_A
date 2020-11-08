import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsa_gram/Forms/ProfileForm.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/widgets/Button.dart';

class ProfileScreen extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    if (user == null) {
      return Container();
    }

    return Column(
      children: <Widget>[
        if (user.photoURL != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image(
              image: NetworkImage(user.photoURL),
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            ),
          )
        else
          Container(),
        Text('Email: ' + user.email),
        if (user.displayName != null)
          Text('Display Name: ' + user.displayName)
        else
          Container(),
        Button(
          label: 'Logout',
          onSubmit: () {
            _auth.signOut(context);
            return null;
          },
        ),
        ProfileForm(),
      ],
    );
  }
}
