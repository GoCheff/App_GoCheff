import 'dart:convert';

import 'package:customer_app/data/env.dart';
import 'package:customer_app/data/types.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  var baseUrl = '${Env.API_URL}/customer';

  Future<Response> login(
      {required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/sign-in');

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    bool error = response.statusCode != 200;

    return Response.fromJson(jsonDecode(response.body), error: error);
  }
}

class CustomerLoginResponse extends Response {
  final String token;
  final String message;

  CustomerLoginResponse({required this.token, required data, bool error = false, required this.message})
      : super(data: data, error: false, message: message);

  factory CustomerLoginResponse.fromJson(Map<String, dynamic> json) {
    return CustomerLoginResponse(
        token: json['token'], message: json['message'], data: json['data']);
  }
}
