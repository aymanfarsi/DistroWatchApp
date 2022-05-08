import 'dart:convert';

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

  // get rankings
  static Future<List<dynamic>?> getRankings() async {
    const String url =
        'https://raw.githubusercontent.com/jamezrin/distrowatch-data/master/rankings.json';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
