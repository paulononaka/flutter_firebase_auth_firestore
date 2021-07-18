import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  AuthManager() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final _logoutController = StreamController<bool>.broadcast();

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  Future<void> signUp({required final String email, required final String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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

  Future<void> logout() async {
    await _firebaseAuth.signOut();
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
