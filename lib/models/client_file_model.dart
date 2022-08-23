import 'package:cloud_firestore/cloud_firestore.dart';

class ClientFile {
  final String name;
  final String networkFile;
  final Timestamp date;
  const ClientFile(
      {required this.name, required this.networkFile, required this.date});

  factory ClientFile.fromJson(Map<String, dynamic> json) => ClientFile(
        name: json['name'],
        networkFile: json['file'],
        date: json['date'],
      );
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'file': networkFile,
      "date": date,
    };
  }

  static List<ClientFile> toList(List data) {
    List<ClientFile> res = [];
    for (var datum in data) {
      res.add(ClientFile.fromJson(datum));
    }
    return res;
  }
}
