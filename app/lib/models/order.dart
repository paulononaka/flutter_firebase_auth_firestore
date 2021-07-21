import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  factory Order({
    required String userUid,
    required String testName,
    required String createdAt,
    required String resultDate,
    required String result,
  }) = _Order;

  Order._();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
