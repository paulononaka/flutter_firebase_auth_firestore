import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/models/sti_std.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.freezed.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.fetchStiStdList() = _FetchStiStdList;

  const factory OrderEvent.tapOnTest({
    required final NavigatorState navigator,
    required final StiStd stiStd,
  }) = _TapOnTest;
}
