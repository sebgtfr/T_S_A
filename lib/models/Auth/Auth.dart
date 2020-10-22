import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get user {
    return _auth.currentUser;
  }

  Future<dynamic> signIn(String email, String password) async {
    return await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential user) {
      notifyListeners();
      print(_auth.currentUser);
      return true;
    });
    // .catchError((e) {
    //   print('Firebase: Failed with error code: ${e.code}');
    //   // print(e.message);
    //   return false;
    // });
  }

  Future<dynamic> signUp(String email, String password) async {
    return await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential user) {
      notifyListeners();
      print(_auth.currentUser);
      return true;
    });
    // .catchError((e) {
    //   print('Firebase: Failed with error code: ${e.code}');
    //   // print(e.message);
    //   return false;
    // });
  }

  Future signOut() async {
    return await _auth.signOut().then((value) => notifyListeners());
  }
}
