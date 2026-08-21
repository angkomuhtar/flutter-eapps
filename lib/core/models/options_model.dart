class HazardLocationModel {
  final int id;
  final String name;

  HazardLocationModel({required this.id, required this.name});

  factory HazardLocationModel.fromJson(Map<String, dynamic> json) {
    return HazardLocationModel(id: json['id'], name: json['location']);
  }
}

class CompanyModel {
  final int id;
  final String name;

  CompanyModel({required this.id, required this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(id: json['id'], name: json['company']);
  }
}

class ProjectModel {
  final int id;
  final String name;
  final String code;

  ProjectModel({required this.id, required this.name, required this.code});

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(id: json['id'], name: json['name'], code: json['code']);
  }
}

class DepartementModel {
  final int id;
  final String name;
  final String acronim;

  DepartementModel({
    required this.id,
    required this.name,
    required this.acronim,
  });

  factory DepartementModel.fromJson(Map<String, dynamic> json) {
    return DepartementModel(
      id: json['id'],
      name: json['division'],
      acronim: json['acronim'] ?? '',
    );
  }
}

class VersionModel {
  final int id;
  final String version;
  final String build_number;
  final String device;
  final String url;

  VersionModel({
    required this.id,
    required this.version,
    required this.build_number,
    required this.device,
    required this.url,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) {
    return VersionModel(
      id: json['id'],
      version: json['version'],
      build_number: json['build_number'] ?? '0',
      device: json['device'],
      url: json['download'],
    );
  }
}
