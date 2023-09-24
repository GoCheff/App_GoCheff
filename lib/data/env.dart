import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static var API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');
}