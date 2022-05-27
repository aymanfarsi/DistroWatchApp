class HeadlineModel {
  String title;
  String link;
  String guid;
  DateTime pubDate;

  HeadlineModel({
    required this.title,
    required this.link,
    required this.guid,
    required this.pubDate,
  });

  factory HeadlineModel.fromJson(Map<String, dynamic> json) {
    return HeadlineModel(
      title: json['title'] as String,
      link: json['link'] as String,
      guid: json['guid'] as String,
      pubDate: DateTime.parse(json['pubDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'guid': guid,
      'pubDate': pubDate.toIso8601String(),
    };
  }
}
