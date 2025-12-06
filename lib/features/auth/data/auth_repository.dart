import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_eapps/core/network/dio_client.dart';
import 'package:flutter_eapps/core/utils/device_info_service.dart';

class AuthRepository {
  final Dio _dio;
  final DeviceInfoService _deviceInfoService;
  static const _tokenKey = 'auth_token';

  AuthRepository(this._dio, this._deviceInfoService);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final deviceId = await _deviceInfoService.getDeviceId();
    final response = await _dio.post(
      '/auth/login',
      data: {'email': username, 'password': password, 'phone_id': deviceId},
    );

    final data = response.data;
    if (data['success'] == false || data['status'] != 'success') {
      throw Exception(data['message'] ?? 'Login gagal');
    }

    return data['user'];
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user['id']);
    await prefs.setString('username', user['username'] ?? '');
    await prefs.setString('email', user['email'] ?? '');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove('user_id');
    await prefs.remove('username');
    await prefs.remove('email');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    return userId != null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(mainDioProvider),
    ref.watch(deviceInfoServiceProvider),
  );
});
