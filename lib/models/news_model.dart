class NewsModel {
  final String data;
  final String title;
  final DateTime dateUpdated;
  const NewsModel(
      {required this.data, required this.dateUpdated, required this.title});
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      data: json['data'],
      title: json['title'],
      dateUpdated: DateTime.parse(
        json['date'],
      ));
  Map<String, Object?> toJson() {
    return {
      'data': data,
      'date': dateUpdated.toIso8601String(),
      'title': title,
    };
  }
}
