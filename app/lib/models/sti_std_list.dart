import 'package:flutter_firebase_auth_firestore/models/sti_std.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sti_std_list.freezed.dart';
part 'sti_std_list.g.dart';

@freezed
class StiStdList with _$StiStdList {
  factory StiStdList({required List<StiStd> stiStdList}) = _StiStdList;

  StiStdList._();

  factory StiStdList.fromJson(Map<String, dynamic> json) => _$StiStdListFromJson(json);
}
