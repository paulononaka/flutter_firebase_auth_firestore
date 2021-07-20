import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.freezed.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.fetchStiStdList() = _FetchStiStdList;

  const factory OrderEvent.tapOnSignUp({required final NavigatorState navigator}) = _TapOnSignUp;

  const factory OrderEvent.tapOnOrder({
    required final NavigatorState navigator,
    required final String email,
    required final String password,
  }) = _TapOnOrder;
}
