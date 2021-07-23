import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.tapOnUpdate({
    required final NavigatorState navigator,
    required final String name,
    required final bool notificationsEnabled,
  }) = _TapOnUpdate;

  const factory ProfileEvent.fetchUser(TextEditingController nameController) = _fetchUser;
}
