import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.tapOnSignUp({
    required final NavigatorState navigatorState,
    required final String email,
    required final String password,
  }) = _TapOnSignUp;

  const factory SignUpEvent.tapOnSignIn({
    required final NavigatorState navigatorState,
  }) = _TapOnSignIn;
}
