class UnitsModel {
  final int id;
  final String unit_code;
  final String plate_number;
  final int unit_type_id;
  final String unit_type;
  final String unit_category;
  final String unit_cat_code;
  final int unit_model_id;
  final String brand;
  final String model;

  UnitsModel({
    required this.id,
    required this.unit_code,
    required this.plate_number,
    required this.unit_type_id,
    required this.unit_type,
    required this.unit_category,
    required this.unit_cat_code,
    required this.unit_model_id,
    required this.brand,
    required this.model,
  });

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      id: json['id_unit'] ?? json['id'],
      unit_code: json['unit_code'] == null ? '-' : json['unit_code'],
      plate_number: json['plate_number'] == null ? '-' : json['plate_number'],
      unit_type_id: json['unit_type_id'],
      unit_type: json['unit_type'] == null ? '-' : json['unit_type'],
      unit_category: json['unit_category'] == null
          ? '-'
          : json['unit_category'],
      unit_cat_code: json['unit_cat_code'] == null
          ? '-'
          : json['unit_cat_code'],
      unit_model_id: json['unit_model_id'],
      brand: json['brand'] == null ? '-' : json['brand'],
      model: json['model'] == null ? '-' : json['model'],
    );
  }
}

class UnitCategoryModel {
  final int id;
  final String code;
  final String name;

  UnitCategoryModel({required this.id, required this.code, required this.name});

  factory UnitCategoryModel.fromJson(Map<String, dynamic> json) {
    return UnitCategoryModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
    );
  }
}
