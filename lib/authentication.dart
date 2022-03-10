import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drexeltwo/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drexeltwo/utlities.dart' as utilities;

//put all authentication functionality in one place to reduce calls to database

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //add user to database
  void register(String username, String password, BuildContext context) async {
    try {
      final UserCredential regcred =
          (await _auth.createUserWithEmailAndPassword(
              email: username + "@drexel.edu", password: password));

      utilities.User user = utilities.User(
          username: username,
          uid: regcred.user!.uid,
          followers: [],
          following: [],
          bio: '');
      await _firestore
          .collection('users')
          .doc(regcred.user!.uid)
          .set(user.toJson());

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (e) {
      print(e.toString());
    }
  }

  //if user is already in database, log them in
  void login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username + '@drexel.edu', password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<utilities.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return utilities.User.fromSnapshot(snap);
  }
}
