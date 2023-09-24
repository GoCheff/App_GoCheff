import 'package:http/http.dart' as http;

Future<String> downloadImage(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return imageUrl;
    } else {
      return 'URL do ícone de perfil padrão';
    }
  } catch (e) {
    return 'URL do ícone de perfil padrão';
  }
}
