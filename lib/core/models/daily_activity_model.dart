import 'package:flutter_eapps/core/models/units_model.dart';

class DailyActivityModel {
  final int id;
  final int location_id;
  final String location;
  final String other_location;
  final String job_type;
  final UnitsModel? unit;
  final String? sts_unit;
  final String start_time;
  final String end_time;
  final int duration;
  final String activity;
  final String desc;
  final String status;
  final Creator created_by;

  DailyActivityModel({
    required this.id,
    required this.location_id,
    required this.location,
    required this.other_location,
    required this.job_type,
    this.unit,
    this.sts_unit,
    required this.activity,
    required this.start_time,
    required this.end_time,
    required this.duration,
    required this.desc,
    required this.status,
    required this.created_by,
  });

  factory DailyActivityModel.fromJson(Map<String, dynamic> json) {
    return DailyActivityModel(
      id: json['id'],
      location_id: json['id_location'],
      location: json['location']['location'],
      other_location: json['other_location'] ?? '-',
      job_type: json['job_type'],
      unit: json['unit_detail'] != null
          ? UnitsModel.fromJson(json['unit_detail'])
          : null,
      sts_unit: json['sts_unit'],
      activity: json['activity'] ?? "-",
      start_time: json['start_time'],
      end_time: json['end_time'],
      duration: json['duration'],
      desc: json['desc'],
      status: json['status'],
      created_by: Creator.fromJson(json['created_by']),
    );
  }
}

class Creator {
  final int id;
  final String nama;
  final String departement;
  final String position;

  Creator({
    required this.id,
    required this.nama,
    required this.departement,
    required this.position,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      nama: json['profile']['name'],
      departement: json['employee']['division']['division'],
      position: json['employee']['position']['position'],
    );
  }
}
