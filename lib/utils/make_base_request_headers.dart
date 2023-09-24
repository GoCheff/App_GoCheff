Map<String, String> makeBaseRequestHeaders({String? token}) {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}