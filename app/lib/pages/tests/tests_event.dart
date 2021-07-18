import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tests_event.freezed.dart';

@freezed
class TestsEvent with _$TestsEvent {
  const factory TestsEvent.tapOnTests({
    required final NavigatorState navigator,
    required final String email,
    required final String password,
  }) = _TapOnTests;

  const factory TestsEvent.tapOnSignUp({
    required final NavigatorState navigator,
  }) = _TapOnSignUp;
}
