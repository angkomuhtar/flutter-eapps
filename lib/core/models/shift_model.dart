class ShiftModel {
  final int id;
  final String whCode;
  final String shiftCode;
  final String name;
  final String start;
  final String end;
  final String rest;
  final String days;
  final int restDuration;

  ShiftModel({
    required this.id,
    required this.whCode,
    required this.shiftCode,
    required this.name,
    required this.start,
    required this.end,
    required this.rest,
    required this.days,
    required this.restDuration,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'],
      whCode: json['wh_code'],
      shiftCode: json['shift_code'],
      name: json['name'],
      start: json['start'],
      end: json['end'],
      rest: json['rest'],
      days: json['days'],
      restDuration: json['rest_duration'],
    );
  }
}
