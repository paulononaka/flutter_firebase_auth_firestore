import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.freezed.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.tapOnOrder({
    required final NavigatorState navigatorState,
    required final String email,
    required final String password,
  }) = _TapOnOrder;

  const factory OrderEvent.tapOnSignUp({
    required final NavigatorState navigatorState,
  }) = _TapOnSignUp;
}
