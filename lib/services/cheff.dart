import 'dart:convert';
import 'dart:core';

import 'package:customer_app/data/env.dart';
import 'package:customer_app/data/types.dart';
import 'package:customer_app/utils/make_base_request_headers.dart';
import 'package:http/http.dart' as http;

class CheffService {
  var baseUrl = '${Env.API_URL}/customers/cheffs';

  Future<Response> getAll({required String token}) async {
    var url = Uri.parse('$baseUrl/');
    var headers = makeBaseRequestHeaders(token: token);

    final response = await http.get(url, headers: headers);

    bool error = response.statusCode != 200;

    if (error) {
      return ErrorResponseBody.fromJson(jsonDecode(response.body));
    }

    return CheffGetAllResponse.fromJson(jsonDecode(response.body));
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
