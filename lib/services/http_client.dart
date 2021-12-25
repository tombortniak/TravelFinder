import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  Future get(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return '';
    }
  }
}
