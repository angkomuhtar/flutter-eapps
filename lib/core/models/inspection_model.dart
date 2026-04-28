import 'package:flutter_eapps/core/models/hazard_model.dart';

class InspectionListModel {
  final int id;
  final String? other_location;
  final String inspection_number;
  final String status;
  final String shift;
  final String date;
  final Location location;
  final Inspection inspection;

  InspectionListModel({
    required this.id,
    this.other_location,
    required this.inspection_number,
    required this.status,
    required this.shift,
    required this.date,
    required this.location,
    required this.inspection,
  });

  factory InspectionListModel.fromJson(Map<String, dynamic> json) {
    return InspectionListModel(
      id: json['id'],
      other_location: json['other_location'] ?? '',
      inspection_number: json['inspection_number'],
      status: json['status'],
      shift: json['shift'],
      date: json['inspection_date'],
      location: Location.fromJson(json['location']),
      inspection: Inspection.fromJson(json['inspection']),
    );
  }
}

class Inspection {
  final int id;
  final String name;
  final String slug;
  final String status;

  Inspection({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json['id'],
      name: json['inspection_name'],
      slug: json['slug'],
      status: json['status'],
    );
  }
}

class User {
  final String name;
  final String nrp;
  final String division;
  final String position;

  User({
    required this.name,
    required this.nrp,
    required this.division,
    required this.position,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      nrp: json['nrp'],
      division: json['division'],
      position: json['position'],
    );
  }
}

class InspectionQuestion {
  final int id;
  final String sub_inspenction;
  final String status;
  final Inspection inspection;
  final List<Question> questions;

  InspectionQuestion({
    required this.id,
    required this.sub_inspenction,
    required this.status,
    required this.inspection,
    required this.questions,
  });

  factory InspectionQuestion.fromJson(Map<String, dynamic> json) {
    return InspectionQuestion(
      id: json['id'],
      sub_inspenction: json['sub_inspection_name'],
      status: json['status'],
      inspection: Inspection.fromJson(json['inspection']),
      questions: (json['question'] as List)
          .map((e) => Question.fromJson(e))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String slug;
  final String question;
  final String status;

  Question({
    required this.id,
    required this.slug,
    required this.question,
    required this.status,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      slug: json['slug'],
      question: json['question'],
      status: json['status'],
    );
  }
}

class InspectionType {
  final int id;
  final String name;
  final String slug;
  final String status;

  InspectionType({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
  });

  factory InspectionType.fromJson(Map<String, dynamic> json) {
    return InspectionType(
      id: json['id'],
      name: json['inspection_name'],
      slug: json['slug'],
      status: json['status'],
    );
  }
}

class Answer {
  final String answer;
  final String? note;
  final String? due_date;
  final String question_slug;
  final String question;
  final String status;

  Answer({
    required this.answer,
    this.note,
    this.due_date,
    required this.question_slug,
    required this.question,
    required this.status,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'],
      note: json['note'],
      due_date: json['due_date'],
      question_slug: json['question_slug'],
      question: json['question'],
      status: json['status'],
    );
  }
}

class GroupedAnswer {
  final String sub_inspection;
  final List<Answer> answers;

  GroupedAnswer({required this.sub_inspection, required this.answers});

  factory GroupedAnswer.fromJson(Map<String, dynamic> json) {
    return GroupedAnswer(
      sub_inspection: json['sub_inspection_name'],
      answers: (json['items'] as List).map((e) => Answer.fromJson(e)).toList(),
    );
  }
}

class InspectionDetail {
  final int id;
  final String inspection_number;
  final String? other_location;
  final String status;
  final String shift;
  final String detail_location;
  final String inspection_date;
  final String recomended_action;
  final List<GroupedAnswer> answers;
  final Location location;
  final Inspection inspection;
  final User? creator;
  final User? supervisor;

  InspectionDetail({
    required this.id,
    required this.inspection_number,
    this.other_location,
    required this.status,
    required this.shift,
    required this.detail_location,
    required this.inspection_date,
    required this.recomended_action,
    required this.answers,
    required this.location,
    required this.inspection,
    this.creator,
    this.supervisor,
  });

  factory InspectionDetail.fromJson(Map<String, dynamic> json) {
    return InspectionDetail(
      id: json['id'],
      inspection_number: json['inspection_number'],
      other_location: json['other_location'],
      status: json['status'],
      shift: json['shift'],
      detail_location: json['detail_location'],
      inspection_date: json['inspection_date'],
      recomended_action: json['recomended_action'],
      answers: (json['grouped_answer'] as List)
          .map((e) => GroupedAnswer.fromJson(e))
          .toList(),
      location: Location.fromJson(json['location']),
      inspection: Inspection.fromJson(json['inspection']),
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      supervisor: json['supervisor'] != null
          ? User.fromJson(json['supervisor'])
          : null,
    );
  }
}
