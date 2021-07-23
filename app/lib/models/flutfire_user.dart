import 'package:freezed_annotation/freezed_annotation.dart';

part 'flutfire_user.freezed.dart';
part 'flutfire_user.g.dart';

@freezed
class FlutfireUser with _$FlutfireUser {
  @JsonSerializable(explicitToJson: true)
  factory FlutfireUser({
    String? uid,
    String? deviceToken,
    required String email,
    required String name,
    required DateTime dateOfBith,
    required String gender,
    required String genitalia,
  }) = _FlutfireUser;

  factory FlutfireUser.fromJson(Map<String, dynamic> json) => _$FlutfireUserFromJson(json);
}
