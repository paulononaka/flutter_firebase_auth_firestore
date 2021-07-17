import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_state.freezed.dart';

@freezed
class WelcomeState with _$WelcomeState {
  const factory WelcomeState.loading() = _Loading;
  const factory WelcomeState.loaded() = _Loaded;
}
