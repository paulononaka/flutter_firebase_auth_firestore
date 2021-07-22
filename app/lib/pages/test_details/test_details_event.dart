import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_details_event.freezed.dart';

@freezed
class TestDetailsEvent with _$TestDetailsEvent {
  const factory TestDetailsEvent.deleteOrder({
    required final NavigatorState navigator,
    required final Order order,
  }) = _DeleteOrder;

  const factory TestDetailsEvent.updateNotes({
    required final NavigatorState navigator,
    required final Order order,
    required final String notes,
  }) = _UpdateNotes;

  const factory TestDetailsEvent.sendEmail({
    required final NavigatorState navigator,
    required final Order order,
  }) = _SendEmail;
}
