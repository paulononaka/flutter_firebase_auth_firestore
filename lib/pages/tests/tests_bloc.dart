import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'tests_event.dart';
import 'tests_state.dart';

class TestsBloc extends Bloc<TestsEvent, TestsState> {
  TestsBloc({required this.authManager}) : super(const TestsState.loaded());

  final AuthManager authManager;

  @override
  Stream<TestsState> mapEventToState(TestsEvent event) async* {
    yield* event.when(tapOnTests: _tapOnTests, tapOnSignUp: _tapOnSignUp);
  }

  Stream<TestsState> _tapOnTests(
      NavigatorState navigatorState, String email, String password) async* {
    try {
      yield const TestsState.loading();
      await authManager.signIn(email: email, password: password);
      navigatorState.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield TestsState.error(e.message);
    } catch (e) {
      yield const TestsState.error('An unknown error happened :(');
    }
  }

  Stream<TestsState> _tapOnSignUp(NavigatorState navigatorState) async* {
    navigatorState.pushReplacementNamed(Routes.signUp);
  }
}
