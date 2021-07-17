import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.authManager}) : super(const SignUpState.loaded());

  final AuthManager authManager;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    yield* event.when(tapOnSignUp: _tapOnSignUp);
  }

  Stream<SignUpState> _tapOnSignUp(
      NavigatorState navigatorState, String email, String password) async* {
    try {
      yield const SignUpState.loading();
      await authManager.signUp(email: email, password: password);
      await navigatorState.pushNamed(Routes.home);
    } catch (e) {
      debugPrint(e.toString());
    }
    yield const SignUpState.loaded();
  }
}
