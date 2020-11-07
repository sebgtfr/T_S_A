import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tsa_gram/models/UserModel.dart';

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
    return _auth.userChanges().map((User user) => user);
  }

  Future<User> signIn(String email, String password) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) => userCredential.user);
  }

  Future<void> signUp(
      final String email, final String password, final String displayName) {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) =>
            this.createUser(userCredential.user, displayName, null));
  }

  Future<void> createUser(
      final User userData, final String displayName, final String photoUrl) {
    return _db.collection('users').doc(userData.uid).set({
      'email': userData.email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    }).then((void dummy) => userData.updateProfile(displayName: displayName));
  }

  UserModel getUserById() {}

  Future<void> updateUser(
      final User userData, final String displayName, final String photoUrl) {
    return _db.collection('users').doc(userData.uid).set({
      'displayName': displayName,
      'photoUrl': photoUrl,
    }).then(
      (void dummy) => userData.updateProfile(
        displayName: displayName,
        photoURL: photoUrl,
      ),
    );
  }

  Future<void> updateUserEmail(final User userData, final String email) {
    return _db.collection('users').doc(userData.uid).set({
      'email': email,
    }).then(
      (void dummy) => userData.updateEmail(email),
    );
  }

  Future<List<QueryDocumentSnapshot>> getUsers() {
    return _db
        .collection('users')
        .get()
        .then((QuerySnapshot query) => query.docs);
  }

  Future<void> forgot(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut(BuildContext context) {
    return _auth.signOut();
  }
}
