import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/models/user_model.dart';
import 'package:flutter_eapps/core/utils/device_info_service.dart';
import 'package:flutter_eapps/modules/auth/auth_repository.dart';
import 'package:flutter_eapps/modules/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final loginLoadingProvider = StateProvider<bool>((ref) => false);

class AuthNotifier extends AsyncNotifier<AuthState> {
  late final AuthRepository _repo;

  @override
  Future<AuthState> build() async {
    _repo = ref.read(authRepositoryProvider);

    await Future.delayed(const Duration(milliseconds: 1500));

    final token = await _repo.getToken();
    if (token == null) {
      return const AuthState(AuthStatus.unauthenticated);
    }
    return const AuthState(AuthStatus.authenticated);
  }

  Future<void> login(String email, String password, Dio dio) async {
    final loadingNotifier = ref.read(loginLoadingProvider.notifier);
    final deviceId = await ref.read(deviceIdProvider.future);
    loadingNotifier.state = true;

    try {
      final res = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password, 'phone_id': deviceId},
      );

      await _repo.saveToken(res.data['authorisation']['token']);
      final user = UserModel.fromJson(res.data['user']);
      await _repo.saveUser(user);

      state = AsyncData(AuthState(AuthStatus.authenticated, user: user));
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException && e.response != null) {
        debugPrint('Status: ${e.response?.statusCode}');
        debugPrint('Response: ${e.response?.data['message']}');
        state = AsyncData(
          AuthState(
            AuthStatus.unauthenticated,
            error:
                e.response?.data['message'] ??
                'Terjadi kesalahan saat login. Silakan coba lagi.',
          ),
        );
      } else {
        state = AsyncData(
          AuthState(AuthStatus.unauthenticated, error: errorMessage),
        );
      }
    } finally {
      loadingNotifier.state = false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncData(AuthState(AuthStatus.unauthenticated));
  }

  Future<void> forceLogout() async {
    await _repo.logout();
    state = const AsyncData(AuthState(AuthStatus.unauthenticated));
  }
}

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  await Future.delayed(const Duration(milliseconds: 150));
  return ref.watch(authRepositoryProvider).getUser();
});
