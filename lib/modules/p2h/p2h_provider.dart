import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/p2h_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'p2h_provider.g.dart';

@riverpod
class GetP2hInspection extends _$GetP2hInspection {
  late Dio _dio;

  @override
  Future<List<P2hHeader>> build(String id_unit) async {
    _dio = ref.read(dioProvider(ApiType.p2h));
    return _fetch(id_unit);
  }

  Future<List<P2hHeader>> _fetch(String id_unit) async {
    try {
      final res = await _dio.get('units/inspection/$id_unit');
      final List data = res.data['data'];
      // print(data);
      final items = data.map((e) {
        // print(e);
        return P2hHeader.fromJson(e);
      }).toList();
      print('Fetched PIC list: ${items.length} items');
      return items;
    } catch (e) {
      debugPrint('Error fetching PIC details: $e');
      throw Exception('Failed to load PIC details: $e');
    }
  }
}

@riverpod
class SubmitP2h extends _$SubmitP2h {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.p2h));
  }

  Future<(bool, String?)> upload(Map<String, dynamic> data) async {
    try {
      final unit_id = data['unit_id'];
      await _dio.post('/my-form-masters/${unit_id}/store', data: data);
      // ref.read(getP2hInspectionProvider.notifier).refresh();
      return (true, null);
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan';
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        debugPrint('DioException: ${e.response}, Status code: $statusCode');
        errorMessage = getErrorMessage(statusCode ?? 0);
      }
      return (false, errorMessage);
    }
  }
}
