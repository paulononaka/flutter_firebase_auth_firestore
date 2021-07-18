import 'package:freezed_annotation/freezed_annotation.dart';

part 'tests_state.freezed.dart';

@freezed
class TestsState with _$TestsState {
  const factory TestsState.loading() = _Loading;
  const factory TestsState.loaded() = _Loaded;
  const factory TestsState.error(String message) = _Error;
}
