import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.logout() = _Logout;

  const factory HomeEvent.tapOnOrder({
    required final NavigatorState navigatorState,
  }) = _TapOnOrder;
}
