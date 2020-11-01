import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/common/Layout.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';

class HomeScreen extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Layout(
      child: Column(
        children: [
          Text('coucou light',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText2
                  .copyWith(fontSize: 50)),
          Text('coucou regular',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText1
                  .copyWith(fontSize: 50)),
          Text('coucou bold',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1
                  .copyWith(fontSize: 50)),
          Text("Bonjour " + user.email,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText1
                  .copyWith(fontSize: 25)),
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
      ),
    );
  }
}
