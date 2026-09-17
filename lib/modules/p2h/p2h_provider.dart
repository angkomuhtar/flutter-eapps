import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/appr_p2h_model.dart';
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
        return P2hHeader.fromJson(e);
      }).toList();
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

@riverpod
class HistoryP2h extends _$HistoryP2h {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<P2hModel> _items = [];

  @override
  Future<List<P2hModel>> build({String filter = ""}) async {
    _dio = ref.read(dioProvider(ApiType.p2h));
    _filter = filter;
    return _fetch(reset: true);
  }

  Future<List<P2hModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get(
        '/my-form-masters/history',
        queryParameters: {'page': _page},
      );

      final data = res.data['data']['formMasters'];

      final List list = data['data'];

      final newItems = list.map((e) {
        // print('Fetched P2H history item: $e');
        return P2hModel.fromJson(e);
      }).toList();

      _items.addAll(newItems);

      final currentPage = data['current_page'];
      final lastPage = data['last_page'];

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;
      return _items;
    } catch (e) {
      debugPrint('Error fetching P2H history: $e');
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    state = await AsyncValue.guard(() async {
      return await _fetch();
    });
  }

  bool get hasMore => _hasMore;
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _fetch(reset: true);
    });
  }
}

@riverpod
class CloseP2h extends _$CloseP2h {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.p2h));
  }

  Future<(bool, String?)> upload(Map<String, dynamic> data) async {
    try {
      final form_id = data['id'];
      await _dio.post('/my-form-masters/${form_id}/close', data: data);
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

@riverpod
class MyP2hForm extends _$MyP2hForm {
  late Dio _dio;

  @override
  Future<String?> build() async {
    _dio = ref.read(dioProvider(ApiType.p2h));
    return _fetch();
  }

  Future<String?> _fetch() async {
    try {
      final res = await _dio.get('/my-form-masters');
      final data = res.data['data']['formMasters'] ?? null;
      return data.toString();
    } catch (e) {
      debugPrint('Error fetching PIC details: $e');
      throw Exception('Failed to load PIC details: $e');
    }
  }
}
