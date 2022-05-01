import 'package:http/http.dart' as http;

class FetchData {
  static Future<String?> _sendRequest({
    required String url,
  }) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> getData() async {
    const String url = 'https://distrowatch.com/news/dw.xml';
    return _sendRequest(url: url);
  }

  static Future<String?> getDetails({
    required String section,
  }) async {
    String url = 'https://distrowatch.com/table.php?distribution=$section';
    return _sendRequest(url: url);
  }
}
