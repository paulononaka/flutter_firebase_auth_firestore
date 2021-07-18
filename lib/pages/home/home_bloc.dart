import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.authManager}) : super(const HomeState.loaded());

  final AuthManager authManager;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield* event.when(logout: _logout);
  }

  Stream<HomeState> _logout() async* {
    yield const HomeState.loading();
    authManager.logout();
  }
}
