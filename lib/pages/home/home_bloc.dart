import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.auth}) : super(const HomeState.loaded());

  final AuthManager auth;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield* event.when(
      logout: _logout,
      tapOnOrder: _tapOnOrder,
      tapOnTests: _tapOnTests,
      tapOnProfile: _tapOnProfile,
    );
  }

  Stream<HomeState> _logout() async* {
    yield const HomeState.loading();
    auth.logout();
  }

  Stream<HomeState> _tapOnOrder(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.order);
  }

  Stream<HomeState> _tapOnTests(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.tests);
  }

  Stream<HomeState> _tapOnProfile(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.profile);
  }
}
