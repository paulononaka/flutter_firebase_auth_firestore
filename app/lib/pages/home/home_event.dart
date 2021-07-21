import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.loadHome() = _FetchOrderList;
  const factory HomeEvent.logout() = _Logout;
  const factory HomeEvent.tapOnOrder({required final NavigatorState navigator}) = _TapOnOrder;
  const factory HomeEvent.tapOnTests({required final NavigatorState navigator}) = _TapOnTests;
  const factory HomeEvent.tapOnProfile({required final NavigatorState navigator}) = _TapOnProfile;
}
