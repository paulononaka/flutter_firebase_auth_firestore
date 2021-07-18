import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.authManager}) : super(const ProfileState.loaded());

  final AuthManager authManager;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    yield* event.when(tapOnProfile: _tapOnProfile, tapOnSignUp: _tapOnSignUp);
  }

  Stream<ProfileState> _tapOnProfile(
      NavigatorState navigatorState, String email, String password) async* {
    try {
      yield const ProfileState.loading();
      await authManager.signIn(email: email, password: password);
      navigatorState.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield ProfileState.error(e.message);
    } catch (e) {
      yield const ProfileState.error('An unknown error happened :(');
    }
  }

  Stream<ProfileState> _tapOnSignUp(NavigatorState navigatorState) async* {
    navigatorState.pushReplacementNamed(Routes.signUp);
  }
}
