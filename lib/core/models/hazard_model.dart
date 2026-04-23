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
  final Division? division;
  final Company? company;
  final Project? project;
  final UserProfile? reporter;
  final Action? action;

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
    this.division,
    this.company,
    this.project,
    this.reporter,
    this.action,
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
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : null,
      division: json['division'] != null
          ? Division.fromJson(json['division'])
          : null,
      project: json['project'] != null
          ? Project.fromJson(json['project'])
          : null,
      reporter: json['created_by'] != null
          ? UserProfile.fromJson(json['created_by'])
          : null,
      action: json['hazard_action'] != null
          ? Action.fromJson(json['hazard_action'])
          : null,
    );
  }
}

class HazardItemModel {
  final int id;
  final String hazard_number;
  final String date;
  final String category;
  final String condition;
  final String due_date;
  final String status;
  final String? other_location;
  final Location? location;
  final Division? division;

  HazardItemModel({
    required this.id,
    required this.hazard_number,
    required this.date,
    required this.category,
    required this.condition,
    required this.due_date,
    required this.status,
    required this.location,
    required this.division,
    this.other_location,
  });

  factory HazardItemModel.fromJson(Map<String, dynamic> json) {
    return HazardItemModel(
      id: json['id'],
      hazard_number: json['hazard_report_number'],
      date: json['date_time'],
      category: json['category'],
      condition: json['reported_condition'],
      other_location: json['other_location'],
      due_date: json['due_date'],
      status: json['status'],
      division: json['division'] != null
          ? Division.fromJson(json['division'])
          : null,
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
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

class Division {
  final int id;
  final String name;
  final String code;

  Division({required this.id, required this.name, required this.code});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'],
      name: json['division'],
      code: json['acronim'],
    );
  }
}

class Company {
  final int id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(id: json['id'], name: json['company']);
  }
}

class Project {
  final int id;
  final String name;
  final String code;

  Project({required this.id, required this.name, required this.code});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'] ?? '-',
      code: json['code'] ?? '-',
    );
  }
}

class Action {
  final int id;
  final String? image;
  final String status;
  final String? notes;
  final UserProfile? pic;
  final UserProfile? supervisor;
  final String? created_at;
  final String? updated_at;

  Action({
    required this.id,
    required this.status,
    this.image,
    this.notes,
    this.pic,
    this.supervisor,
    this.created_at,
    this.updated_at,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      id: json['id'],
      status: json['status'],
      image: json['attachment'] ?? null,
      notes: json['notes'] ?? '-',
      pic: json['pic'] != null ? UserProfile.fromJson(json['pic']) : null,
      supervisor: json['supervised_by'] != null
          ? UserProfile.fromJson(json['supervised_by'])
          : null,
      created_at: json['created_at'] ?? null,
      updated_at: json['updated_at'] ?? null,
    );
  }
}

class UserProfile {
  final int id;
  final String name;
  final String username;
  final String dept;
  final String position;

  UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.dept,
    required this.position,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['profile']['name'] ?? '-',
      username: json['username'] ?? '-',
      dept: json['employee']?['division']?['division'] ?? '-',
      position: json['employee']?['position']?['position'] ?? '-',
    );
  }
}
