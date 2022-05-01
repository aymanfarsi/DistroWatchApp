import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class CustomWebScraper {
  static Future<Map<String, dynamic>> getDistroDetails(
      {required String section}) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://distrowatch.com/table.php?distribution=$section',
      ),
    );
    Document document = parse(response.body);
    List<Element> elements = document.querySelectorAll(
      "td > ul > li",
    );
    Map<String, dynamic> info = {};
    for (Element element in elements) {
      List<String> data = element.text.trim().split(' ');
      if (element.text.contains('Based on')) {
        info['Based on'] = data.getRange(2, data.length).join(' ');
      } else if (element.text.contains('Origin')) {
        info['Origin'] = data[1];
      } else if (element.text.contains('Architecture')) {
        info['Architecture'] = data[1];
      } else if (element.text.contains('Desktop:')) {
        info['Desktop'] = data.getRange(1, data.length).join(' ');
      } else if (element.text.contains('Category:')) {
        info['Category'] = data.getRange(1, data.length).join(' ');
      } else if (element.text.contains('Status')) {
        info['Status'] = data[1];
      }
    }
    info['Last Update'] = document
        .querySelector(
          "td > div",
        )!
        .innerHtml;

    // Part 2
    elements = document.querySelectorAll(
      "table.Info > tbody > tr",
    );
    for (Element element in elements) {
      List<String> data = element.text.trim().split(' ');
      if (data.first.contains('Distribution')) {
        info['Distribution'] = data.last;
      } else if (element.text.contains('Home Page')) {
        info['URL'] = data.last;
      } else if (element.text.contains('Screenshots')) {
        info['Screenshots'] = element.querySelector('a')!.attributes['href'];
      } else if (element.text.contains('Download Mirrors')) {
        info['Downloads'] = data.last;
      }
    }
    return info;
  }
}
