class P2hHeader {
  final int id;
  final String name;
  final String order;
  final List<FormChecklistModel> form_checklist;

  P2hHeader({
    required this.id,
    required this.name,
    required this.order,
    required this.form_checklist,
  });

  factory P2hHeader.fromJson(Map<String, dynamic> json) {
    return P2hHeader(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      form_checklist: (json['form_checklist'] as List<dynamic>? ?? [])
          .map(
            (item) => FormChecklistModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class FormChecklistModel {
  final int id;
  final int unit_type_id;
  final int form_header_id;
  final int form_category_id;
  final String question;
  final FormCategoryModel form_category;

  FormChecklistModel({
    required this.id,
    required this.unit_type_id,
    required this.form_header_id,
    required this.form_category_id,
    required this.question,
    required this.form_category,
  });

  factory FormChecklistModel.fromJson(Map<String, dynamic> json) {
    return FormChecklistModel(
      id: json['id'],
      unit_type_id: json['unit_type_id'],
      form_header_id: json['form_header_id'],
      form_category_id: json['form_category_id'],
      question: json['question'],
      form_category: FormCategoryModel.fromJson(json['form_category']),
    );
  }
}

class FormCategoryModel {
  final int id;
  final String symbol;
  final String color;
  final String description;

  FormCategoryModel({
    required this.id,
    required this.symbol,
    required this.color,
    required this.description,
  });

  factory FormCategoryModel.fromJson(Map<String, dynamic> json) {
    return FormCategoryModel(
      id: json['id'],
      symbol: json['symbol'],
      color: json['color'],
      description: json['description'],
    );
  }
}
