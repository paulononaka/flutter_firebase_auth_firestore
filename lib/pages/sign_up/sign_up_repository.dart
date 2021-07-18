import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/user.dart';

class SignUpRepository {
  SignUpRepository({required this.auth}) : _firestore = FirebaseFirestore.instance;

  final AuthManager auth;
  final FirebaseFirestore _firestore;

  Future<void> signUp({required User user, required String password}) async {
    CollectionReference users = _firestore.collection('users');
    await auth.signUp(email: user.email, password: password);
    try {
      await users.add(user.toJson());
    } catch (e) {
      await auth.deleteCurrentUser();
      rethrow;
    }
  }
}
