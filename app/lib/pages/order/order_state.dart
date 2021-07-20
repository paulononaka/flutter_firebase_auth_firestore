import 'package:flutter_firebase_auth_firestore/models/sti_std_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.loading() = _Loading;
  const factory OrderState.loaded(StiStdList stiStdList) = _Loaded;
  const factory OrderState.error(String message) = _Error;
}
