import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.loaded() = _Loaded;
}
