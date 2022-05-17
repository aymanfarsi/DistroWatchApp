class PackageModel {
  String title;
  String url;
  String description;
  String dayMonth;

  PackageModel({
    required this.title,
    required this.url,
    required this.description,
    required this.dayMonth,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        title: json["title"],
        url: json["url"],
        description: json["section"],
        dayMonth: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "section": description,
        "date": dayMonth,
      };
}
