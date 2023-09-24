import 'dart:convert';
import 'dart:core';

import 'package:customer_app/data/env.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/utils/make_base_request_headers.dart';
import 'package:http/http.dart' as http;

class CheffService {
  var baseUrl = '${Env.API_URL}/customers/cheffs';

  Future<Response> getAll(
      {required String token,
      String? mainCuisine,
      String? city,
      bool? glutenFree,
      bool? lactoseFree,
      bool? vegan,
      bool? vegetarian,
      bool? light}) async {
    String query = '';
    List<String> filters = [];

    if (mainCuisine != null) filters.add('mainCuisine=$mainCuisine');
    if (city != null) filters.add('city=$city');
    if (glutenFree == true) filters.add('glutenFree=$glutenFree');
    if (lactoseFree == true) filters.add('lactoseFree=$lactoseFree');
    if (vegan == true) filters.add('vegan=$vegan');
    if (vegetarian == true) filters.add('vegetarian=$vegetarian');
    if (light == true) filters.add('light=$light');
    if (filters.isNotEmpty) query = '?${filters.join('&')}';

    var url = Uri.parse('$baseUrl$query');
    var headers = makeBaseRequestHeaders(token: token);

    print('GET $url');

    final response = await http.get(url, headers: headers);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CheffGetAllResponse.fromJson(jsonDecode(response.body));
  }

  Future<Response> get({required String token, required int cheffId}) async {
    var url = Uri.parse('$baseUrl/$cheffId');
    var headers = makeBaseRequestHeaders(token: token);

    final response = await http.get(url, headers: headers);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CheffGetResponse.fromJson(jsonDecode(response.body));
  }
}

class CheffGetAllResponse extends Response {
  late final List<dynamic> cheffs;

  CheffGetAllResponse({required data, bool error = false, required message})
      : super(data: data, error: false, message: message) {
    cheffs = data;
  }

  CheffGetAllResponse.fromJson(Map<String, dynamic> json, {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    cheffs = json['data'];
  }
}

class CheffGetResponse extends Response {
  late final dynamic cheff;

  CheffGetResponse({required data, bool error = false, required message})
      : super(data: data, error: false, message: message) {
    cheff = data;
  }

  CheffGetResponse.fromJson(Map<String, dynamic> json, {bool error = false})
      : super(data: json, error: error, message: json['message']) {
    cheff = json['data'];
  }
}
