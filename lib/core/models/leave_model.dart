class AbsenceTypeModel {
  final int id;
  final String name;
  final String code;

  AbsenceTypeModel({required this.id, required this.name, required this.code});

  factory AbsenceTypeModel.fromJson(Map<String, dynamic> json) {
    return AbsenceTypeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class EstimationModel {
  final String start_date;
  final double raw;
  final int usable;
  final double remainder;
  final int maxDays;

  EstimationModel({
    required this.start_date,
    required this.raw,
    required this.usable,
    required this.remainder,
    required this.maxDays,
  });

  factory EstimationModel.fromJson(Map<String, dynamic> json) {
    return EstimationModel(
      start_date: json['as_of'] ?? '',
      raw: (json['raw'] ?? 0).toDouble(),
      usable: json['usable'] ?? 0,
      remainder: (json['remainder'] ?? 0).toDouble(),
      maxDays: json['rosterMax'] ?? 0,
    );
  }
}

class DailyLeaveKuotaModel {
  final String today;
  final double total;
  final List<AbsenceTypeModel> absenceType;
  final int maxDays;
  final int usable;

  DailyLeaveKuotaModel({
    required this.today,
    required this.total,
    required this.absenceType,
    required this.maxDays,
    required this.usable,
  });

  factory DailyLeaveKuotaModel.fromJson(Map<String, dynamic> json) {
    return DailyLeaveKuotaModel(
      today: json['today'] ?? '',
      total: (json['total'] ?? 0).toDouble(),
      absenceType:
          (json['absenceTypes'] as List?)
              ?.map((e) => AbsenceTypeModel.fromJson(e))
              .toList() ??
          [],
      maxDays: json['estimation']['rosterMax'] ?? 0,
      usable: json['estimation']['usable'] ?? 0,
    );
  }
}

class ListLeaveModel {
  final int id;
  final String status;
  final int total_days;
  final String? notes;
  final String start_date;
  final String end_date;
  final AbsenceTypeModel absence_type;

  ListLeaveModel({
    required this.id,
    required this.status,
    required this.total_days,
    this.notes,
    required this.start_date,
    required this.end_date,
    required this.absence_type,
  });

  factory ListLeaveModel.fromJson(Map<String, dynamic> json) {
    return ListLeaveModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      total_days: json['total_days'] ?? 0,
      notes: json['notes'] ?? '-',
      start_date: json['start_date'] ?? '',
      end_date: json['end_date'] ?? '',
      absence_type: AbsenceTypeModel.fromJson(json['absence_type'] ?? {}),
    );
  }
}

class ApprovalModel {
  final int id;
  final String role;
  final String status;
  final String notes;
  final String? approved_at;
  final ApproverModel approver;

  ApprovalModel({
    required this.id,
    required this.role,
    required this.status,
    required this.notes,
    this.approved_at,
    required this.approver,
  });

  factory ApprovalModel.fromJson(Map<String, dynamic> json) {
    return ApprovalModel(
      id: json['id'] ?? 0,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '-',
      approved_at: json['approved_at'] ?? null,
      approver: ApproverModel.fromJson(json['approver'] ?? {}),
    );
  }
}

class ApproverModel {
  final int id;
  final String name;

  ApproverModel({required this.id, required this.name});

  factory ApproverModel.fromJson(Map<String, dynamic> json) {
    return ApproverModel(id: json['id'] ?? 0, name: json['name'] ?? '-');
  }
}

class DetailLeaveModel {
  final int id;
  final String status;
  final int total_days;
  final String? notes;
  final String start_date;
  final String end_date;
  final AbsenceTypeModel absence_type;
  final List<ApprovalModel> approvals;

  DetailLeaveModel({
    required this.id,
    required this.status,
    required this.total_days,
    this.notes,
    required this.start_date,
    required this.end_date,
    required this.absence_type,
    required this.approvals,
  });

  factory DetailLeaveModel.fromJson(Map<String, dynamic> json) {
    return DetailLeaveModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      total_days: json['total_days'] ?? 0,
      notes: json['notes'] ?? '-',
      start_date: json['start_date'] ?? '',
      end_date: json['end_date'] ?? '',
      absence_type: AbsenceTypeModel.fromJson(json['absence_type'] ?? {}),
      approvals:
          (json['approvals'] as List?)
              ?.map((e) => ApprovalModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
