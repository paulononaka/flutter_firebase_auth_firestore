import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class Endpoint {
  static String stiStd(final String genitalia) => '/sti_std/${genitalia.toLowerCase()}';
}

class RestClient {
  RestClient({required String baseUrl}) : _baseUrl = baseUrl;

  final Encoding? _utf8 = Encoding.getByName('utf-8');
  final String _baseUrl;

  Future<String> request({
    final String? fullUrl,
    final String? path,
    final String? payload,
  }) async {
    final url = fullUrl ?? '$_baseUrl$path';

    Response response;
    try {
      response = (payload == null)
          ? await get(Uri.parse(url))
          : await post(Uri.parse(url), body: payload, encoding: _utf8);
    } catch (exception) {
      throw ConnectionException(exception);
    }

    return response.body;
  }
}

class ConnectionException implements Exception {
  ConnectionException(this.cause);
  dynamic cause;
}