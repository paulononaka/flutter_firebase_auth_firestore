import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_firestore/firebase/push_notification.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthManager {
  AuthManager({required this.pushNotification})
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;

  final PushNotification pushNotification;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final _logoutController = StreamController<bool>.broadcast();

  bool get isLoggedIn => _auth.currentUser != null;

  Future<void> signUp({required FlutfireUser user, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
      try {
        user = user.copyWith(
          uid: _auth.currentUser!.uid,
          deviceToken: await pushNotification.deviceToken,
        );
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

  Future<void> update({required String name, bool? notificationsEnabled}) async {
    try {
      var doc = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await doc.update({'name': name});
      if (notificationsEnabled != null) {
        await doc.update({
          'deviceToken': notificationsEnabled ? await pushNotification.deviceToken : null,
        });
      }
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
            fromFirestore: (doc, _) => FlutfireUser.fromJson(doc.data()!),
            toFirestore: (doc, _) => doc.toJson(),
          )
          .get()
          .then((doc) => doc.data()!);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Can't find logged user. Logging out...",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      try {
        await _auth.currentUser?.delete();
      } finally {
        await logout();
      }
      throw AuthException(e, 'An unknown error returing user :(');
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
