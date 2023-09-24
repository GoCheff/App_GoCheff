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

  ErrorResponseBody.fromJson(Map<String, dynamic> json, {bool error = true})
      : message = json['message'],
        super(data: json['data'], error: error, message: json['message']);
}

enum Gender {
  male,
  female,
  other,
  preferNotToSay,
}

Gender parseGender(String value) {
  switch (value) {
    case "male":
      return Gender.male;
    case "female":
      return Gender.female;
    case "other":
      return Gender.other;
    case "preferNotToSay":
      return Gender.preferNotToSay;
    default:
      return Gender.other;
  }
}
