import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  AuthManager() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  Future<void> signUp({required final String email, required final String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(e, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(e, 'The account already exists for that email.');
      } else {
        rethrow;
      }
    } catch (e) {
      throw AuthException(e, 'An unknown error Sign Up error happened :(');
    }
  }

  Future<void> signIn({required final String email, required final String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(e, 'No user found for the provided email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException(e, 'Wrong password provided.');
      } else {
        rethrow;
      }
    } catch (e) {
      throw AuthException(e, 'An unknown error Sign In error happened :(');
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

class AuthException implements Exception {
  AuthException(this.cause, this.message);
  String message;
  dynamic cause;
}
