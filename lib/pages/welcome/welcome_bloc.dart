import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState.loaded());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    yield* event.when(tapOnSignUp: _tapOnSignUp, tapOnSignIn: _tapOnSignIn);
  }

  Stream<WelcomeState> _tapOnSignUp(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.signUp);
  }

  Stream<WelcomeState> _tapOnSignIn(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.signIn);
  }
}
