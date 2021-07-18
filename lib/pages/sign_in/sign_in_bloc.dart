import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.authManager}) : super(const SignInState.loaded());

  final AuthManager authManager;

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    yield* event.when(tapOnSignIn: _tapOnSignIn);
  }

  Stream<SignInState> _tapOnSignIn(
      NavigatorState navigatorState, String email, String password) async* {
    try {
      yield const SignInState.loading();
      await authManager.signIn(email: email, password: password);
      await navigatorState.pushNamedAndRemoveUntil(Routes.home, (_) => false);
      yield const SignInState.loaded();
    } on AuthException catch (e) {
      yield SignInState.error(e.message);
    } catch (e) {
      yield const SignInState.error('An unknown error happened :(');
    }
  }
}
