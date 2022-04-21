import 'package:http/http.dart' as http;

class FetchData {
  static Future<String?> getData() async {
    const String url = 'https://distrowatch.com/news/dw.xml';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}