class DistroModel {
  String title;
  String url;
  String description;
  DateTime date;
  String section;

  DistroModel({
    required this.title,
    required this.url,
    required this.description,
    required this.date,
    required this.section,
  });

  factory DistroModel.fromJson(Map<String, dynamic> json) {
    return DistroModel(
      title: json['title'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      section: json['section'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'description': description,
      'date': date.toIso8601String(),
      'section': section,
    };
  }
}
