import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.auth}) : super(const SignInState.loaded());

  final AuthManager auth;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    yield* event.when(tapOnSignIn: _tapOnSignIn, tapOnSignUp: _tapOnSignUp);
  }

  Stream<SignInState> _tapOnSignIn(NavigatorState navigator, String email, String password) async* {
    try {
      yield const SignInState.loading();
      await auth.signIn(email: email, password: password);
      navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield SignInState.error(e.message);
    } catch (e) {
      yield const SignInState.error('An unknown Server error happened :(');
    }
  }

  Stream<SignInState> _tapOnSignUp(NavigatorState navigator) async* {
    navigator.pushReplacementNamed(Routes.signUp);
  }
}
