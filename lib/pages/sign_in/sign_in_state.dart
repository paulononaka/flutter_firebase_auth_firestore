import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.loading() = _Loading;
  const factory SignInState.loaded() = _Loaded;
  const factory SignInState.error(String message) = _Error;
}
