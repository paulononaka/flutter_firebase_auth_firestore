import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(FlutfireUser user) = _Loaded;
  const factory ProfileState.error(String message) = _Error;
}
