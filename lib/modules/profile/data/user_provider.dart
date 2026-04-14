import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final int? id;
  final String name;
  final String email;
  final String position;
  final String department;
  final String? avatarUrl;

  UserData({
    this.id,
    this.name = '',
    this.email = '',
    this.position = '',
    this.department = '',
    this.avatarUrl,
  });
}

class UserNotifier extends StateNotifier<UserData> {
  UserNotifier() : super(UserData());

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    state = UserData(
      id: prefs.getInt('user_id'),
      name: prefs.getString('username') ?? '',
      email: prefs.getString('email') ?? '',
      position: prefs.getString('position') ?? '-',
      department: prefs.getString('department') ?? '-',
      avatarUrl: prefs.getString('avatar_url'),
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserData>((ref) {
  return UserNotifier();
});
