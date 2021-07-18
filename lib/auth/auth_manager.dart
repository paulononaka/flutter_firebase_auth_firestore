import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';

class AuthManager {
  AuthManager()
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final _logoutController = StreamController<bool>.broadcast();

  bool get isLoggedIn => _auth.currentUser != null;

  Future<void> signUp({required FlutfireUser user, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      try {
        await _firestore.collection('users').doc(_auth.currentUser!.uid).set(user.toJson());
      } catch (e) {
        await _auth.currentUser?.delete();
        rethrow;
      }
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        throw AuthException(e, e.message!);
      } else {
        rethrow;
      }
    } catch (e) {
      throw AuthException(e, 'An unknown Sign Up error happened :(');
    }
  }

  Future<void> signIn({required final String email, required final String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.message != null) {
        throw AuthException(e, e.message!);
      } else {
        rethrow;
      }
    } catch (e) {
      throw AuthException(e, 'An unknown Sign In error happened :(');
    }
  }

  Future<void> update({required String name}) async {
    try {
      var user = await currentUser();
      user = user.copyWith(name: name);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set(user.toJson());
    } catch (e) {
      throw AuthException(e, 'An unknown error happened when updating user :(');
    }
  }

  Future<FlutfireUser> currentUser() async {
    try {
      return await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .withConverter<FlutfireUser>(
            fromFirestore: (snapshot, _) => FlutfireUser.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          )
          .get()
          .then((snapshot) => snapshot.data()!);
    } catch (e) {
      throw AuthException(e, 'An unknown error happened when updating user :(');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _logoutController.add(true);
  }

  void didLogout(void Function(bool hasLoggedOut) listen) {
    _logoutController.stream.listen(listen);
  }
}

class AuthException implements Exception {
  AuthException(this.cause, this.message);
  String message;
  dynamic cause;
}
