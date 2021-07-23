import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/firebase/push_notification.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'home_event.dart';
import 'home_repository.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.auth,
    required this.repository,
    required this.pushNotification,
  }) : super(const HomeState.initial());

  final AuthManager auth;
  final HomeRepository repository;
  final PushNotification pushNotification;
  bool _isListeningPushes = false;

  final Map<String, int> sickDuration = {
    'Chlamydia': 4,
    'Gonorrhea': 6,
    'Genital herpes': 8,
    'Syphilis': 10,
    'HPV': 5,
    'Trichomoniasis': 5,
  };

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield* event.when(
      logout: _logout,
      loadHome: _loadHome,
      tapOnTest: _tapOnTest,
      tapOnOrder: _tapOnOrder,
      tapOnTests: _tapOnTests,
      tapOnProfile: _tapOnProfile,
    );
  }

  Stream<HomeState> _loadHome() async* {
    if (!_isListeningPushes) {
      _isListeningPushes = true;
      pushNotification.onHomeUpdate((Map<String, dynamic> _) {
        add(const HomeEvent.loadHome());
      });
    }
    try {
      yield const HomeState.loading();
      var user = await auth.currentUser();
      final response = await repository.fetchRecentOrders(user.uid!);

      final now = DateTime.now();
      final positiveList = response.orderList.where((order) =>
          order.result == 'positive' &&
          order.createdAt.add(Duration(minutes: sickDuration[order.testName]!)).compareTo(now) > 0);
      final illnesses = positiveList.map((order) => order.testName).join(' / ');
      yield HomeState.loaded(response.orderList, illnesses);
    } catch (e) {
      yield const HomeState.error('An unknown Server error happened :(');
    }
  }

  Stream<HomeState> _logout() async* {
    yield const HomeState.loading();
    auth.logout();
  }

  Stream<HomeState> _tapOnOrder(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.order);
  }

  Stream<HomeState> _tapOnTest(NavigatorState navigator, Order order) async* {
    navigator.pushNamed(Routes.testDetails, arguments: order);
  }

  Stream<HomeState> _tapOnTests(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.tests);
  }

  Stream<HomeState> _tapOnProfile(NavigatorState navigator) async* {
    navigator.pushNamed(Routes.profile);
  }
}
