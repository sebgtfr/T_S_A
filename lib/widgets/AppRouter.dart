import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tsa_gram/screen/Connected/BaseScreen.dart';
import 'package:tsa_gram/screen/AuthScreen.dart';

class AppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder:
          (final BuildContext context, final User user, final Widget child) =>
              user == null ? AuthScreen() : BaseScreen(),
    );
  }
}
