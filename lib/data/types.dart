class Response {
  final bool error;
  final String message;
  final data;

  Response({required this.error, required this.data, required this.message});

  factory Response.fromJson(Map<String, dynamic> json, {bool error = false}) {
    return Response(error: error, data: json['data'], message: json['message']);
  }
}

class ErrorResponseBody extends Response {
  final String message;

  ErrorResponseBody({required this.message, required data, bool error = true})
      : super(data: data, error: error, message: message);

  factory ErrorResponseBody.fromJson(Map<String, dynamic> json) {
    return ErrorResponseBody(message: json['message'], data: json['data']);
  }
}