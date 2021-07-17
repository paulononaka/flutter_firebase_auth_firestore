import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_event.freezed.dart';

@freezed
class WelcomeEvent with _$WelcomeEvent {
  const factory WelcomeEvent.tapOnSignUp(NavigatorState navigatorState) = _Load;
}
