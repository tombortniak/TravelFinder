import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpManager {
  final String? _url;

  HttpManager({required url}) : _url = url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(_url ?? ''));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return '';
    }
  }
}
