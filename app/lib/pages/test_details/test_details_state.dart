import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_details_state.freezed.dart';

@freezed
class TestDetailsState with _$TestDetailsState {
  const factory TestDetailsState.loaded() = _Loaded;
  const factory TestDetailsState.loading() = _Loading;
  const factory TestDetailsState.error(String message) = _Error;
}
