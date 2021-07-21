import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_list.freezed.dart';
part 'order_list.g.dart';

@freezed
class OrderList with _$OrderList {
  factory OrderList({required List<Order> orderList}) = _OrderList;

  OrderList._();

  factory OrderList.fromJson(Map<String, dynamic> json) => _$OrderListFromJson(json);
}
