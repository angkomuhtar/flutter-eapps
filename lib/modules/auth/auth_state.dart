import 'package:flutter_eapps/core/models/user_model.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? error;

  const AuthState(this.status, {this.user, this.error});
}
