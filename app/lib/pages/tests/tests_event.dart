import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tests_event.freezed.dart';

@freezed
class TestsEvent with _$TestsEvent {
  const factory TestsEvent.fetchOrderList() = _FetchOrderList;

  const factory TestsEvent.tapOnTest({
    required final NavigatorState navigator,
    required final Order order,
  }) = _TapOnTest;
}
