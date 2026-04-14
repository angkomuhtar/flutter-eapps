class HazardModel {
  final int id;
  final String hazard_number;
  final String date;
  final Location? location;
  final String? other_location;
  final String? detail_location;
  final String category;
  final String condition;
  final String recomended_action;
  final String action_taken;
  final String report_attachment;
  final String due_date;
  final String status;

  HazardModel({
    required this.id,
    required this.hazard_number,
    required this.date,
    this.location,
    this.other_location,
    required this.detail_location,
    required this.category,
    required this.condition,
    required this.recomended_action,
    required this.action_taken,
    required this.report_attachment,
    required this.due_date,
    required this.status,
  });

  factory HazardModel.fromJson(Map<String, dynamic> json) {
    return HazardModel(
      id: json['id'],
      hazard_number: json['hazard_report_number'],
      date: json['date_time'],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      other_location: json['other_location'],
      detail_location: json['detail_location'],
      category: json['category'],
      condition: json['reported_condition'],
      recomended_action: json['recomended_action'],
      action_taken: json['action_taken'],
      report_attachment: json['report_attachment'],
      due_date: json['due_date'],
      status: json['status'],
    );
  }
}

class Location {
  final int id;
  final String name;

  Location({required this.id, required this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(id: json['id'], name: json['location']);
  }
}
