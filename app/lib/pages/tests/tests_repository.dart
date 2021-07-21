import 'dart:async';
import 'dart:convert';

import 'package:flutter_firebase_auth_firestore/models/order_list.dart';
import 'package:flutter_firebase_auth_firestore/network/rest_client.dart';

class TestsRepository {
  TestsRepository({required final this.rest});

  final RestClient rest;

  Future<OrderList> fetchTests(String userUid) async {
    final response = await rest.request(path: Endpoint.ordersList(userUid));
    return OrderList.fromJson(jsonDecode(response) as Map<String, dynamic>);
  }
}
