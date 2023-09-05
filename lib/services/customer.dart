import 'dart:convert';
import 'dart:core';

import 'package:customer_app/data/env.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/utils/make_base_request_headers.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  var baseUrl = '${Env.API_URL}/customers';

  Future<Response> login(
      {required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/sign-in');
    var headers = makeBaseRequestHeaders();
    var body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerLoginResponse.fromJson(jsonDecode(response.body));
  }

  Future<Response> auth({required String token}) async {
    var url = Uri.parse('$baseUrl/auth');
    var headers = makeBaseRequestHeaders(token: token);

    final response = await http.get(url, headers: headers);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerAuthResponse.fromJson(jsonDecode(response.body));
  }
}

class CustomerLoginResponse extends Response {
  late final String token;
  late final dynamic user;
  late final String message;

  CustomerLoginResponse(
      {required data, bool error = false, required this.message})
      : super(data: data, error: false, message: message) {
    token = data['token'];
    user = data['user'];
  }

  CustomerLoginResponse.fromJson(Map<String, dynamic> json,
      {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    token = json['data']['token'];
    user = json['data']['user'];
    message = json['message'];
  }
}

class CustomerAuthResponse extends Response {
  late final dynamic user;

  CustomerAuthResponse({required data, bool error = false, required message})
      : super(data: data, error: false, message: message) {
    user = data;
  }

  CustomerAuthResponse.fromJson(Map<String, dynamic> json,
      {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    user = json['data'];
  }
}
