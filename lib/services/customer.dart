import 'dart:convert';
import 'dart:core';

import 'package:customer_app/data/env.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/utils/make_base_request_headers.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  var baseUrl = '${Env.API_URL}/customers';

  Future<Response> login({required String email, required String password}) async {
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

  Future<Response> signup({required String name, required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/sign-up');
    var headers = makeBaseRequestHeaders();
    var body = jsonEncode({'name': name, 'email': email, 'password': password, 'gender': 'preferNotToSay'});

    final response = await http.post(url, headers: headers, body: body);

    bool error = response.statusCode != 201;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerSignupResponse.fromJson(jsonDecode(response.body));
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

  Future<Response> updateOrCreateCartItem(
      {required String token, required int foodPlateId, required int quantity, required int cheffId, required String locale}) async {
    var url = Uri.parse('$baseUrl/cart-items/$foodPlateId');
    var headers = makeBaseRequestHeaders(token: token);

    print(url);
    final response = await http.put(url,
        headers: headers,
        body: jsonEncode({
          "locale": "string",
          "eventDate": "2023-11-08T00:55:13.157Z",
          "phoneContact": "string",
          "observation": "string",
          "cheffId": cheffId,
          "quantity": quantity
        }));

    bool error = response.statusCode != 200;
    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerUpdateOrCreateCartItemResponse.fromJson(jsonDecode(response.body));
  }

  Future<Response> finalizeCart({
    required String token,
    required int idCart,
  }) async {
    var url = Uri.parse('$baseUrl/carts/$idCart');
    var headers = makeBaseRequestHeaders(token: token);

    print(url);
    final response = await http.patch(url, headers: headers, body: jsonEncode({}));

    bool error = response.statusCode != 200;
    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerUpdateOrCreateCartItemResponse.fromJson(jsonDecode(response.body));
  }

  Future<Response> getOrders({required String token}) async {
    var url = Uri.parse('$baseUrl/carts');
    var headers = makeBaseRequestHeaders(token: token);

    print(url);

    final response = await http.get(url, headers: headers);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerGetOrdersResponse.fromJson(jsonDecode(response.body));
  }

  Future<Response> createPayment({required String token, required int cartId}) async {
    var url = Uri.parse('$baseUrl/carts/$cartId/payment');
    var headers = makeBaseRequestHeaders(token: token);

    print(url);

    final response = await http.post(url, headers: headers);

    bool error = response.statusCode != 201;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CustomerCreatePaymentResponse.fromJson(jsonDecode(response.body));
  }
}

class CustomerLoginResponse extends Response {
  late final String token;
  late final dynamic user;
  late final String message;

  CustomerLoginResponse({required data, bool error = false, required this.message}) : super(data: data, error: false, message: message) {
    token = data['token'];
    user = data['user'];
  }

  CustomerLoginResponse.fromJson(Map<String, dynamic> json, {bool error = false}) : super(data: json, error: error, message: json['message']) {
    token = json['data']['token'];
    user = json['data']['user'];
    message = json['message'];
  }
}

class CustomerSignupResponse extends Response {
  late final String message;

  CustomerSignupResponse({required data, bool error = false, required this.message}) : super(data: data, error: false, message: message) {}

  CustomerSignupResponse.fromJson(Map<String, dynamic> json, {bool error = false}) : super(data: json, error: error, message: json['message']) {
    message = json['message'];
  }
}

class CustomerAuthResponse extends Response {
  late final dynamic user;

  CustomerAuthResponse({required data, bool error = false, required message}) : super(data: data, error: false, message: message) {
    user = data;
  }

  CustomerAuthResponse.fromJson(Map<String, dynamic> json, {bool error = false}) : super(data: json, error: error, message: json['message']) {
    user = json['data'];
  }
}

class CustomerUpdateOrCreateCartItemResponse extends Response {
  late final dynamic cartItem;

  CustomerUpdateOrCreateCartItemResponse({required data, bool error = false, required message}) : super(data: data, error: false, message: message) {
    cartItem = data;
  }

  CustomerUpdateOrCreateCartItemResponse.fromJson(Map<String, dynamic> json, {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    cartItem = json['data'];
  }
}

class CustomerGetOrdersResponse extends Response {
  late final List<dynamic> carts;

  CustomerGetOrdersResponse({required data, bool error = false, required message}) : super(data: data, error: false, message: message) {
    carts = data;
  }

  CustomerGetOrdersResponse.fromJson(Map<String, dynamic> json, {bool error = false}) : super(data: json, error: error, message: json['message']) {
    carts = json['data'];
  }
}

class CustomerCreatePaymentResponse extends Response {
  late final String paymentLink;

  CustomerCreatePaymentResponse({required data, bool error = false, required message}) : super(data: data, error: false, message: message) {
    paymentLink = data['paymentLink'];
  }

  CustomerCreatePaymentResponse.fromJson(Map<String, dynamic> json, {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    paymentLink = json['data']['paymentLink'];
  }
}
