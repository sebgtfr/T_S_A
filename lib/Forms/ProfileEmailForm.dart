import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';

import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final Auth _auth = Auth();

  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);

    _emailController.text = user.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder:
          (final BuildContext context, final User user, final Widget child) =>
              Form(
        key: _formKey,
        child: Column(
          children: [
            TextInput(
              controller: _emailController,
              labelText: 'Email',
              obscured: false,
            ),
            SizedBox(height: 20),
            Button(
              label: 'Update Email',
              onValidate: () => _formKey.currentState.validate(),
              onSubmit: () {
                if (_emailController.text != user.email) {
                  _auth.updateUserEmail(user, _emailController.text);
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
