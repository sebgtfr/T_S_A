import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _store = FirebaseStorage.instance;

  FirebaseAuth get auth {
    return _auth;
  }

  FirebaseFirestore get db {
    return _db;
  }

  FirebaseStorage get store {
    return _store;
  }

  Stream<User> get user {
    return _auth.authStateChanges().map((user) => user);
  }

  Future<UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> forgot(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut(BuildContext context) {
    return _auth.signOut();
  }
}
