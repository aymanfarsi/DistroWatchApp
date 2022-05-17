class NewDistroModel {
  String title;
  String url;
  String section;
  String dayMonth;

  NewDistroModel({
    required this.title,
    required this.url,
    required this.section,
    required this.dayMonth,
  });

  factory NewDistroModel.fromJson(Map<String, dynamic> json) => NewDistroModel(
        title: json["title"],
        url: json["url"],
        section: json["section"],
        dayMonth: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "section": section,
        "date": dayMonth,
      };
}
