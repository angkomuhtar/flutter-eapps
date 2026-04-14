import 'package:flutter_eapps/core/models/user_model.dart';

class AuthModel {
  final String token;
  final UserModel user;

  AuthModel({required this.token, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['authorisation']['token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
