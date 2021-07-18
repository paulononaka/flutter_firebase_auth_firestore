import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.tapOnProfile({
    required final NavigatorState navigatorState,
    required final String email,
    required final String password,
  }) = _TapOnProfile;

  const factory ProfileEvent.tapOnSignUp({
    required final NavigatorState navigatorState,
  }) = _TapOnSignUp;
}
