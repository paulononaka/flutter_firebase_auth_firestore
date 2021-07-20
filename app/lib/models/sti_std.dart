import 'package:freezed_annotation/freezed_annotation.dart';

part 'sti_std.freezed.dart';
part 'sti_std.g.dart';

@freezed
class StiStd with _$StiStd {
  factory StiStd({
    required String name,
    required List<String> genitalia,
    required String information,
    required int duration,
  }) = _StiStd;

  StiStd._();

  factory StiStd.fromJson(Map<String, dynamic> json) => _$StiStdFromJson(json);
}
