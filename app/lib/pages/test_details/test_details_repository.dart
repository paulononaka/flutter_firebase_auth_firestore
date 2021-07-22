import 'dart:async';

import 'package:flutter_firebase_auth_firestore/models/flutfire_user.dart';
import 'package:flutter_firebase_auth_firestore/models/order.dart';
import 'package:flutter_firebase_auth_firestore/network/rest_client.dart';

class TestDetailsRepository {
  TestDetailsRepository({required final this.rest});

  final RestClient rest;

  Future<void> deleteTest({required FlutfireUser user, required Order order}) async {
    await rest.request(path: Endpoint.deleteOrder(user.uid!, order.id));
  }

  Future<void> updateNotes({
    required FlutfireUser user,
    required Order order,
    required String notes,
  }) async {
    await rest.request(path: Endpoint.updateOrderNote(user.uid!, order.id, notes));
  }

  Future<void> sendEmail({required FlutfireUser user, required Order order}) async {
    await rest.request(path: Endpoint.deleteOrder(user.uid!, order.id));
  }
}
