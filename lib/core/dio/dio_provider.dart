import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/dio/auth_interceptor.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider.family<Dio, ApiType>((ref, type) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl(type)));

  dio.interceptors.add(AuthInterceptor(ref, dio));

  return dio;
});
