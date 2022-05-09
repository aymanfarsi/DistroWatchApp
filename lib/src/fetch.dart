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

  static Future<String?> getLatestDistros() async {
    return null;
  }

  static Future<String?> getRandomDistro() async {
    const String url = 'https://distrowatch.com/random.php?';
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
