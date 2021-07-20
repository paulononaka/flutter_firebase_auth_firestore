import 'dart:async';
import 'dart:convert';

import 'package:flutter_firebase_auth_firestore/models/sti_std_list.dart';
import 'package:flutter_firebase_auth_firestore/network/rest_client.dart';

class OrderRepository {
  OrderRepository({required final this.rest});

  final RestClient rest;

  Future<StiStdList> fetchStiStd(String genitalia) async {
    final response = await rest.request(path: Endpoint.stiStd(genitalia));
    return StiStdList.fromJson(jsonDecode(response) as Map<String, dynamic>);
  }
}
