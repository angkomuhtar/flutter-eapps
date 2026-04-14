import 'package:flutter_eapps/core/models/employee.model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String roles;
  final String status;
  final EmployeeModel? employee;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.roles,
    required this.status,
    this.employee,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['profile']['name'],
      username: json['username'],
      email: json['email'],
      roles: json['user_roles'],
      status: json['status'],
      employee: json['employee'] != null
          ? EmployeeModel.fromJson(json['employee'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': {'name': name},
      'username': username,
      'email': email,
      'user_roles': roles,
      'status': status,
      'employee': employee?.toJson(),
    };
  }
}
