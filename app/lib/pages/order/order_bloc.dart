import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/sti_std.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'order_event.dart';
import 'order_repository.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required this.auth, required this.repository}) : super(const OrderState.loading());

  final AuthManager auth;
  final OrderRepository repository;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    yield* event.when(
      fetchStiStdList: _fetchStiStdList,
      tapOnTest: _tapOnTest,
    );
  }

  Stream<OrderState> _fetchStiStdList() async* {
    try {
      var user = await auth.currentUser();
      final response = await repository.fetchStiStd(user.genitalia);
      yield OrderState.loaded(response.stiStdList);
    } catch (e) {
      yield const OrderState.error('An unknown Server error happened :(');
    }
  }

  Stream<OrderState> _tapOnTest(NavigatorState navigator, StiStd stiStd) async* {
    try {
      yield const OrderState.loading();
      var user = await auth.currentUser();
      await repository.saveOrder(user: user, stiStd: stiStd);
      Fluttertoast.showToast(
          msg: "Thank you! Your order was successfully submitted!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } catch (e) {
      yield const OrderState.error('An unknown Server error happened :(');
    }
  }
}
