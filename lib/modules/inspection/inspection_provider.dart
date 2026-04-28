import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/core/models/inspection_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inspection_provider.g.dart';

@riverpod
class InspectionHistory extends _$InspectionHistory {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<InspectionListModel> _items = [];

  @override
  Future<List<InspectionListModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(reset: true);
  }

  Future<List<InspectionListModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get(
        '/inspection/history',
        queryParameters: {'page': _page, 'status': _filter},
      );

      final data = res.data['data'];

      debugPrint(data.toString());
      final List list = data['data'];

      final newItems = list
          .map((e) => InspectionListModel.fromJson(e))
          .toList();

      _items.addAll(newItems);

      final currentPage = data['current_page'];
      final lastPage = data['last_page'];

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;

      return _items;
    } catch (e) {
      debugPrint('Error fetching hazards: $e');
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
  String get filter => _filter;

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _fetch(reset: true);
    });
  }

  Future<void> setFilter(String filter) async {
    _filter = filter;
    await refresh();
  }
}

@riverpod
class GetInspection extends _$GetInspection {
  late final Dio _dio;

  @override
  FutureOr<List<InspectionQuestion>> build({required String slug}) async {
    _dio = ref.read(dioProvider(ApiType.empapps));

    try {
      final res = await _dio.get('/inspection/${slug}/question');
      List data = res.data['data'];
      final item = data.map((e) {
        debugPrint(e.toString());
        return InspectionQuestion.fromJson(e);
      }).toList();
      return item;
    } catch (e) {
      debugPrint('Error fetching list question: $e');
      rethrow;
    }
  }
}

@riverpod
class GetInspectionType extends _$GetInspectionType {
  late final Dio _dio;

  @override
  FutureOr<List<InspectionType>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));

    try {
      final res = await _dio.get('/inspection/type');
      List data = res.data['data'];
      final item = data.map((e) {
        debugPrint(e.toString());
        return InspectionType.fromJson(e);
      }).toList();
      return item;
    } catch (e) {
      debugPrint('Error fetching list question: $e');
      rethrow;
    }
  }
}

@riverpod
class UploadInspection extends _$UploadInspection {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<(bool, String?)> upload(Map<String, dynamic> data) async {
    try {
      await _dio.post('/inspection', data: data);
      ref.read(inspectionHistoryProvider.notifier).refresh();
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
class DetailInspection extends _$DetailInspection {
  late Dio _dio;

  @override
  Future<InspectionDetail> build({required String id}) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(id: id);
  }

  Future<InspectionDetail> _fetch({required String id}) async {
    try {
      final res = await _dio.get('/inspection/$id/detail');

      final data = res.data['data'];
      final item = InspectionDetail.fromJson(data);
      return item;
    } catch (e) {
      debugPrint('Error fetching inspection details: $e');
      throw Exception('Failed to load inspection details: $e');
    }
  }
}
