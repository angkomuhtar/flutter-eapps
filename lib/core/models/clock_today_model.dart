class ClockToday {
  final String? check_in;
  final String? check_out;
  final String? date;
  final Late? late;
  final Early? early;
  final Shift? shift;
  final Sleep? sleep;

  ClockToday({
    this.check_in,
    this.check_out,
    this.date,
    this.late,
    this.early,
    this.shift,
    this.sleep,
  });

  factory ClockToday.fromJson(Map<String, dynamic> json) {
    return ClockToday(
      check_in: json['clock_in'] != null ? json['clock_in'] : null,
      check_out: json['clock_out'] != null ? json['clock_out'] : null,
      date: json['date'] != null ? json['date'] : null,
      late: json['late'] != null ? Late.fromJson(json['late']) : null,
      early: json['early'] != null ? Early.fromJson(json['early']) : null,
      shift: json['shift'] != null ? Shift.fromJson(json['shift']) : null,
      sleep: json['sleep'] != null && (json['sleep'] as List).isNotEmpty
          ? Sleep.fromJson(json['sleep'][0])
          : null,
    );
  }
}

class Late {
  final int hours;
  final int minutes;
  final int seconds;

  Late({required this.hours, required this.minutes, required this.seconds});

  factory Late.fromJson(Map<String, dynamic> json) {
    return Late(
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds'],
    );
  }
}

class Early {
  final int hours;
  final int minutes;
  final int seconds;
  Early({required this.hours, required this.minutes, required this.seconds});

  factory Early.fromJson(Map<String, dynamic> json) {
    return Early(
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds'],
    );
  }
}

class Shift {
  final int id;
  final String name;
  final String start;
  final String end;

  Shift({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      name: json['name'],
      start: json['start'],
      end: json['end'],
    );
  }
}

class Sleep {
  final String start;
  final String end;

  Sleep({required this.start, required this.end});

  factory Sleep.fromJson(Map<String, dynamic> json) {
    return Sleep(start: json['start'], end: json['end']);
  }
}

class Rekap {
  final String start;
  final String end;
  final int izin;
  final int alpa;
  final int hadir;

  Rekap({
    required this.start,
    required this.end,
    required this.izin,
    required this.alpa,
    required this.hadir,
  });

  factory Rekap.fromJson(Map<String, dynamic> json) {
    return Rekap(
      start: json['start'],
      end: json['end'],
      izin: json['izin'],
      alpa: json['alpa'],
      hadir: json['hadir'],
    );
  }
}
