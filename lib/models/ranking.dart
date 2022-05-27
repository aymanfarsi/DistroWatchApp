class RankingModel {
  int rank;
  String name;
  String url;
  double value;

  RankingModel({
    required this.rank,
    required this.name,
    required this.url,
    required this.value,
  });

  factory RankingModel.fromJson(Map<String, dynamic> json) {
    return RankingModel(
      rank: int.parse(
        json['rank'].toString(),
      ),
      name: json['name'],
      url: json['url'],
      value: double.parse(
        json['value'].toString(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'name': name,
        'url': url,
        'value': value,
      };
}
