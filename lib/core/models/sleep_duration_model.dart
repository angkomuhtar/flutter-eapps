class SleepDurationModel {
  final String start;
  final String end;
  final String date;
  final String attachment;
  final int stage;
  final String status;

  SleepDurationModel({
    required this.start,
    required this.end,
    required this.date,
    required this.attachment,
    required this.stage,
    required this.status,
  });

  factory SleepDurationModel.fromJson(Map<String, dynamic> json) {
    return SleepDurationModel(
      start: json['start'],
      end: json['end'],
      date: json['date'],
      stage: json['stage'],
      attachment: json['attachment'],
      status: json['status'],
    );
  }
}
