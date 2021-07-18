import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.auth}) : super(const SignUpState.loaded());

  final AuthManager auth;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    yield* event.when(tapOnSignUp: _tapOnSignUp, tapOnSignIn: _tapOnSignIn);
  }

  Stream<SignUpState> _tapOnSignUp(
    NavigatorState navigator,
    FlutfireUser user,
    String password,
  ) async* {
    try {
      yield const SignUpState.loading();
      await auth.signUp(user: user, password: password);
      navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield SignUpState.error(e.message);
    } catch (e) {
      yield const SignUpState.error('An unknown error happened :(');
    }
  }

  Stream<SignUpState> _tapOnSignIn(NavigatorState navigator) async* {
    navigator.pushReplacementNamed(Routes.signIn);
  }
}