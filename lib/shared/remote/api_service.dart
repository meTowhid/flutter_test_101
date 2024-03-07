import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this._baseUrl);

  final String _baseUrl;

  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    final uri = Uri.https(_baseUrl, path, params);
    debugPrint(['REQUEST: $uri'].join('\n'));
    final response = await http.get(uri);
    debugPrint(
      [
        'RESPONSE: $uri',
        response.statusCode.toString(),
        response.body,
      ].join('\n'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> post(String path, dynamic body) async {
    final response = await http.post(
      Uri.parse(_baseUrl + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
