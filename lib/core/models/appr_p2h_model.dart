class FormHeader {
  final int id;
  final String name;
  final String order;

  FormHeader({required this.id, required this.name, required this.order});

  factory FormHeader.fromJson(Map<String, dynamic> json) {
    return FormHeader(id: json['id'], name: json['name'], order: json['order']);
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

class FormMaster {
  final int id;
  final String condition;
  final String? note;
  final String question;
  final FormHeader form_header;
  final FormCategoryModel form_category;

  FormMaster({
    required this.id,
    required this.condition,
    this.note,
    required this.question,
    required this.form_header,
    required this.form_category,
  });

  factory FormMaster.fromJson(Map<String, dynamic> json) {
    return FormMaster(
      id: json['id'],
      condition: json['condition'],
      note: json['note'],
      question: json['form_checklist']['question'],
      form_header: FormHeader.fromJson(json['form_checklist']['form_header']),
      form_category: FormCategoryModel.fromJson(
        json['form_checklist']['form_category'],
      ),
    );
  }
}

class Profile {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}

class User {
  final int id;
  final String email;
  final String? avatar;
  final String name;
  final String nrp;
  final String position;
  final String department;

  User({
    required this.id,
    required this.email,
    this.avatar,
    required this.name,
    required this.nrp,
    required this.position,
    required this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      avatar: json['avatar'],
      name: json['profile']['name'] ?? '',
      nrp: json['employee']['nrp'] ?? '',
      position: json['employee']['position']['name'] ?? '',
      department: json['employee']['division']['acronim'] ?? '',
    );
  }
}

class Unit {
  final int id;
  final String plate_number;
  final String code;
  final String brand;
  final String model;

  Unit({
    required this.id,
    required this.plate_number,
    required this.code,
    required this.brand,
    required this.model,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      plate_number: json['plate_number'],
      code: json['code'],
      brand: json['unit_model']['brand'],
      model: json['unit_model']['model'],
    );
  }
}

class Shift {
  final int id;
  final String name;
  final String start_time;
  final String end_time;

  Shift({
    required this.id,
    required this.name,
    required this.start_time,
    required this.end_time,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      name: json['name'],
      start_time: json['start'],
      end_time: json['end'],
    );
  }
}

class Approval {
  final int id;
  final String status;
  final String note;
  final String role;
  final String? approved_at;
  final User? user;

  Approval({
    required this.id,
    required this.status,
    required this.note,
    required this.role,
    this.approved_at,
    this.user,
  });

  factory Approval.fromJson(Map<String, dynamic> json) {
    return Approval(
      id: json['id'],
      status: json['status'],
      note: json['note'] ?? '',
      role: json['role'] ?? '',
      approved_at: json['approved_at'],
      user: json['approver'] != null ? User.fromJson(json['approver']) : null,
    );
  }
}

class ApprP2hModel {
  final int id;
  final String date;
  final String hm_start;
  final String hm_end;
  final String sleep_duration;
  final String operator_condition;
  final String activity_start_time;
  final String status;
  final String notes;
  final User user;
  final Unit unit;
  final Shift shift;
  final List<FormMaster> form_masters;
  final List<Approval>? approvals;

  ApprP2hModel({
    required this.id,
    required this.date,
    required this.hm_start,
    required this.hm_end,
    required this.sleep_duration,
    required this.operator_condition,
    required this.activity_start_time,
    required this.status,
    required this.notes,
    required this.user,
    required this.unit,
    required this.shift,
    required this.form_masters,
    this.approvals,
  });

  factory ApprP2hModel.fromJson(Map<String, dynamic> json) {
    return ApprP2hModel(
      id: json['id'],
      date: json['date'],
      hm_start: json['hm_start'],
      hm_end: json['hm_end'],
      sleep_duration: json['sleep_duration'],
      operator_condition: json['operator_condition'],
      activity_start_time: json['activity_start_time'],
      status: json['status'],
      notes: json['notes'] ?? '',
      user: User.fromJson(json['user']),
      unit: Unit.fromJson(json['unit']),
      shift: Shift.fromJson(json['work_shift']),
      form_masters: (json['form_master_checklists'] as List<dynamic>)
          .map((e) => FormMaster.fromJson(e))
          .toList(),
      approvals: json['approvals'] != null
          ? (json['approvals'] as List<dynamic>)
                .map((e) => Approval.fromJson(e))
                .toList()
          : null,
    );
  }
}
