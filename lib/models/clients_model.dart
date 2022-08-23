import 'package:summiteagle/models/client_file_model.dart';

class ClientsModel {
  final String name;
  final String? image;
  final List services;
  final List<ClientFile>? files;

  const ClientsModel({
    required this.name,
    required this.services,
    this.image,
    this.files,
  });

  factory ClientsModel.fromJson(Map<String, dynamic> json) => ClientsModel(
        name: json['name'],
        services: json['services'],
        image: json['image'],
        files: json['files'] == null ? null : ClientFile.toList(json['files']),
      );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'image': image,
      'services': services,
      'files': files?.map((e) => e.toJson()).toList() ?? [],
    };
  }
}
