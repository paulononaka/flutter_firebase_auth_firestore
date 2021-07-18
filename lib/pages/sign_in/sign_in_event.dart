import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.tapOnSignIn({
    required final NavigatorState navigatorState,
    required final String email,
    required final String password,
  }) = _TapOnSignIn;

  const factory SignInEvent.tapOnSignUp({
    required final NavigatorState navigatorState,
  }) = _TapOnSignUp;
}
