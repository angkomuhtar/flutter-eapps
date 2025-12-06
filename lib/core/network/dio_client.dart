import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiConfig {
  static const String mainApi = 'https://empapps.mitraabadimahakam.id/api/v2';
  static const String pkwtApi = 'https://e-pkwt.mitraabadimahakam.id/api/v1';
  static const String elearningApi = 'https://e-learning.mitraabadimahakam.id/api/v1';
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('══════════════════════════════════════════════════════════');
    debugPrint('➡️ REQUEST: ${options.method} ${options.uri}');
    debugPrint('Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('Body: ${options.data}');
    }
    debugPrint('══════════════════════════════════════════════════════════');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('══════════════════════════════════════════════════════════');
    debugPrint('✅ RESPONSE [${response.statusCode}]: ${response.requestOptions.uri}');
    debugPrint('Data: ${response.data}');
    debugPrint('══════════════════════════════════════════════════════════');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('══════════════════════════════════════════════════════════');
    debugPrint('❌ ERROR [${err.response?.statusCode}]: ${err.requestOptions.uri}');
    debugPrint('Response: ${err.response?.data}');
    debugPrint('══════════════════════════════════════════════════════════');
    handler.next(err);
  }
}

Dio _createDio(String baseUrl) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
      validateStatus: (status) => status != null && status < 500,
    ),
  );
  dio.interceptors.add(LoggingInterceptor());
  return dio;
}

final mainDioProvider = Provider<Dio>((ref) => _createDio(ApiConfig.mainApi));
final pkwtDioProvider = Provider<Dio>((ref) => _createDio(ApiConfig.pkwtApi));
final elearningDioProvider = Provider<Dio>((ref) => _createDio(ApiConfig.elearningApi));
