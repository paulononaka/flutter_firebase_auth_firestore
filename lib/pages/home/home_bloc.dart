import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.authManager}) : super(const HomeState.loaded());

  final AuthManager authManager;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield* event.when(logout: _logout, tapOnOrder: _tapOnOrder);
  }

  Stream<HomeState> _logout() async* {
    yield const HomeState.loading();
    authManager.logout();
  }

  Stream<HomeState> _tapOnOrder(NavigatorState navigatorState) async* {
    navigatorState.pushNamed(Routes.order);
  }
}
