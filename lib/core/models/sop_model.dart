class ListSopModel {
  final int id;
  final String title;
  final int total_files;

  ListSopModel({
    required this.id,
    required this.title,
    required this.total_files,
  });

  factory ListSopModel.fromJson(Map<String, dynamic> json) {
    return ListSopModel(
      id: json['id'],
      title: json['title'],
      total_files: json['total_files'],
    );
  }
}

class SopDetailsModel {
  final int id;
  final String title;
  final String type;
  final String? url;
  final String fileName;

  SopDetailsModel({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    required this.fileName,
  });

  factory SopDetailsModel.fromJson(Map<String, dynamic> json) {
    return SopDetailsModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
      fileName: json['file_path'] != null
          ? json['file_path'].toString().split('/').last
          : '-',
    );
  }
}
