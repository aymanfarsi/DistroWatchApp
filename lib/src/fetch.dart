import 'dart:convert';

import 'package:dio/dio.dart';

class FetchData {
  static Future<String?> getData() async {
    const String url = 'https://distrowatch.com/news/dw.xml';
    Dio dio = Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  static Future<List<dynamic>?> getRankings() async {
    const String url =
        'https://raw.githubusercontent.com/jamezrin/distrowatch-data/master/rankings.json';
    Dio dio = Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.data);
    } else {
      return null;
    }
  }

  static Future<String?> getLatestDistros() async {
    const String url = 'https://distrowatch.com/news/dwd.xml';
    Dio dio = Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  static Future<String?> getRandomDistro() async {
    const String url = 'https://distrowatch.com/random.php?';
    Dio dio = Dio();
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
