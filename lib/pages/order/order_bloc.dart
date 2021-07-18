import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.auth}) : super(const OrderState.loaded());

  final AuthManager auth;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    yield* event.when(tapOnOrder: _tapOnOrder, tapOnSignUp: _tapOnSignUp);
  }

  Stream<OrderState> _tapOnOrder(
      NavigatorState navigatorState, String email, String password) async* {
    try {
      yield const OrderState.loading();
      await auth.signIn(email: email, password: password);
      navigatorState.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } on AuthException catch (e) {
      yield OrderState.error(e.message);
    } catch (e) {
      yield const OrderState.error('An unknown error happened :(');
    }
  }

  Stream<OrderState> _tapOnSignUp(NavigatorState navigatorState) async* {
    navigatorState.pushReplacementNamed(Routes.signUp);
  }
}
