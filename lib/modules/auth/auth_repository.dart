import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/models/user_model.dart';
import 'package:flutter_eapps/core/storages/secure_storage_provider.dart';
import 'package:flutter_eapps/core/storages/shared_prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(secureStorageProvider),
    ref.read(sharedPrefsProvider),
  );
});

class AuthRepository {
  AuthRepository(this._secure, this._prefs);

  final FlutterSecureStorage _secure;
  final SharedPreferences _prefs;

  static const _tokenKey = 'jwt';
  static const _userKey = 'user';

  Future<String?> getToken() => _secure.read(key: _tokenKey);

  Future<void> saveToken(String token) =>
      _secure.write(key: _tokenKey, value: token);

  Future<void> deleteToken() => _secure.delete(key: _tokenKey);

  Future<UserModel?> getUser() async {
    final json = _prefs.getString(_userKey);
    if (json == null) return null;
    return UserModel.fromJson(jsonDecode(json));
  }

  Future<void> saveUser(UserModel user) =>
      _prefs.setString(_userKey, jsonEncode(user.toJson()));

  Future<void> logout() async {
    await deleteToken();
    await _prefs.remove(_userKey);
  }

  /// dipanggil interceptor
  Future<bool> refreshToken(Dio dio) async {
    try {
      final res = await dio.post('/auth/refresh');
      await saveToken(res.data['token']);
      return true;
    } catch (_) {
      return false;
    }
  }
}
