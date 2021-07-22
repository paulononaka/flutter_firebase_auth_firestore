import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/auth/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'test_details_event.dart';
import 'test_details_repository.dart';
import 'test_details_state.dart';

class TestDetailsBloc extends Bloc<TestDetailsEvent, TestDetailsState> {
  TestDetailsBloc({required this.auth, required this.repository})
      : super(const TestDetailsState.loaded());

  final AuthManager auth;
  final TestDetailsRepository repository;

  @override
  Stream<TestDetailsState> mapEventToState(TestDetailsEvent event) async* {
    yield* event.when(
      deleteOrder: _deleteOrder,
      sendEmail: _sendEmail,
      updateNotes: _updateNotes,
    );
  }

  Stream<TestDetailsState> _deleteOrder(NavigatorState navigator, Order order) async* {
    try {
      var user = await auth.currentUser();
      await repository.deleteTest(user: user, order: order);
      Fluttertoast.showToast(
          msg: "Test was successfully deleted.",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      yield const TestDetailsState.loaded();
    } catch (e) {
      yield const TestDetailsState.error('An unknown Server error happened :(');
    }
  }

  Stream<TestDetailsState> _updateNotes(
      NavigatorState navigator, Order order, String notes) async* {
    try {
      yield const TestDetailsState.loading();
      var user = await auth.currentUser();
      await repository.updateNotes(user: user, order: order, notes: notes);
      Fluttertoast.showToast(
          msg: "Thank you! Your testDetails was successfully submitted!",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      navigator.pop();
    } catch (e) {
      yield const TestDetailsState.error('An unknown Server error happened :(');
    }
  }

  Stream<TestDetailsState> _sendEmail(NavigatorState navigator, Order order) async* {}
}
