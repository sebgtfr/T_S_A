import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsa_gram/Forms/ProfileForm.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/PickImage.dart';

class ProfileScreen extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    if (user == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      child: Container(
        width: double.infinity,
        height: 600,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                if (user.photoURL != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(user.photoURL),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(),
                const SizedBox(width: 20),
                if (user.displayName != null)
                  Text(user.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold))
                else
                  Container(),
              ],
            ),
            ProfileForm(),
            const SizedBox(height: 50),
            Button(
              label: 'Logout',
              onSubmit: () {
                _auth.signOut(context);
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
