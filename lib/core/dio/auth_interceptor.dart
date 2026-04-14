import 'package:dio/dio.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
import 'package:flutter_eapps/modules/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref, this.dio);

  final Ref ref;
  final Dio dio;
  bool _isRefreshing = false;

  @override
  void onRequest(options, handler) async {
    final token = await ref.read(authRepositoryProvider).getToken();
    print('token on request: ${token}');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(err, handler) async {
    print('on Error ');
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      final success = await ref.read(authRepositoryProvider).refreshToken(dio);

      _isRefreshing = false;

      if (success) {
        final token = await ref.read(authRepositoryProvider).getToken();

        err.requestOptions.headers['Authorization'] = 'Bearer $token';

        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      }

      // ❌ refresh gagal → force logout
      await ref.read(authNotifierProvider.notifier).forceLogout();
    }

    handler.next(err);
  }
}
