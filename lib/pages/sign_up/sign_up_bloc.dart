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
    yield* event.when(tapOnSignUp: _tapOnSignUp, tapOnSignIn: _tapOnSignIn);
  }

  Stream<SignUpState> _tapOnSignUp(
    NavigatorState navigatorState,
    String email,
    String password,
    String name,
    DateTime dateOfBith,
    String gender,
    String genitalia,
  ) async* {
    try {
      yield const SignUpState.loading();
      await authManager.signUp(email: email, password: password);
      navigatorState.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield SignUpState.error(e.message);
    } catch (e) {
      yield const SignUpState.error('An unknown error happened :(');
    }
  }

  Stream<SignUpState> _tapOnSignIn(NavigatorState navigatorState) async* {
    navigatorState.pushReplacementNamed(Routes.signIn);
  }
}
