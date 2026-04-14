class EmployeeModel {
  final int id;
  final String nip;
  final String jabatan;
  final int id_jabatan;
  final String divisi;
  final int id_divisi;

  EmployeeModel({
    required this.id,
    required this.nip,
    required this.jabatan,
    required this.id_jabatan,
    required this.divisi,
    required this.id_divisi,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      nip: json['nip'],
      jabatan: json['position']['position'],
      id_jabatan: json['position_id'],
      divisi: json['division']['division'],
      id_divisi: json['division_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nip': nip,
      'position': {'position': jabatan},
      'position_id': id_jabatan,
      'division': {'division': divisi},
      'division_id': id_divisi,
    };
  }
}
