import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.tapOnSignUp({
    required final NavigatorState navigator,
    required final FlutfireUser user,
    required final String password,
  }) = _TapOnSignUp;

  const factory SignUpEvent.tapOnSignIn({
    required final NavigatorState navigator,
  }) = _TapOnSignIn;
}
