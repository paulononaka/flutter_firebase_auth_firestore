import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_firebase_auth_firestore/firebase/auth_manager.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/navigation/app_navigator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'test_details_event.dart';
import 'test_details_repository.dart';
import 'test_details_state.dart';
import 'package:flutter_firebase_auth_firestore/extensions/date_extension.dart';

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
      yield const TestDetailsState.loading();
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
      navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
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
          msg: "Your note was saved successfully.",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 20.0);
      navigator.pushNamedAndRemoveUntil(Routes.home, (_) => false);
    } catch (e) {
      yield const TestDetailsState.error('An unknown Server error happened :(');
    }
  }

  Stream<TestDetailsState> _sendEmail(NavigatorState navigator, Order order) async* {
    final user = await auth.currentUser();
    final Email email = Email(
      body: '''
        <p>Test name: ${order.testName}
        <p>Ordered At: ${order.createdAt.mMMMdyyyyHHmma}
        <p>Resulted At: ${order.resultDate.mMMMdyyyyHHmma}
        <p>Result: ${order.result}
        ''',
      subject: 'Result of test',
      recipients: [user.email],
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
    Fluttertoast.showToast(
        msg: "The test result was sent to your email.",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 20.0);
  }
}
