import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:flutter_firebase_auth_firestore/pages/tests/tests_repository.dart';
import 'tests_event.dart';
import 'tests_state.dart';

class TestsBloc extends Bloc<TestsEvent, TestsState> {
  TestsBloc({required this.auth, required this.repository}) : super(const TestsState.initial());

  final AuthManager auth;
  final TestsRepository repository;

  @override
  Stream<TestsState> mapEventToState(TestsEvent event) async* {
    yield* event.when(
      tapOnTest: _tapOnTest,
      fetchOrderList: _fetchOrderList,
    );
  }

  Stream<TestsState> _fetchOrderList() async* {
    try {
      yield const TestsState.loading();
      var user = await auth.currentUser();
      final response = await repository.fetchTests(user.uid!);
      yield TestsState.loaded(response.orderList);
    } catch (e) {
      yield const TestsState.error('An unknown Server error happened :(');
    }
  }

  Stream<TestsState> _tapOnTest(NavigatorState navigator, Order order) async* {
    try {
      yield const TestsState.loading();
      navigator.pushNamed(Routes.testDetails, arguments: order);
    } on AuthException catch (e) {
      yield TestsState.error(e.message);
    } catch (e) {
      yield const TestsState.error('An unknown Server error happened :(');
    }
  }
}
