import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_report_provider.g.dart';

@riverpod
class ListHazardReport extends _$ListHazardReport {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<HazardItemModel> _items = [];

  @override
  Future<List<HazardItemModel>> build({String filter = ""}) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    _filter = filter;
    return _fetch(reset: true);
  }

  Future<List<HazardItemModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get(
        '/hazard/report',
        queryParameters: {'page': _page, 'status': _filter},
      );

      final data = res.data['data'];

      final List list = data['data'];

      final newItems = list.map((e) => HazardItemModel.fromJson(e)).toList();

      _items.addAll(newItems);

      final currentPage = data['current_page'];
      final lastPage = data['last_page'];

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;
      return _items;
    } catch (e) {
      debugPrint('Error fetching hazard report: $e');
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
class DetailHazardReport extends _$DetailHazardReport {
  late Dio _dio;

  @override
  Future<HazardModel> build({required String id}) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(id: id);
  }

  Future<HazardModel> _fetch({required String id}) async {
    try {
      final res = await _dio.get('/hazard/$id');
      final data = res.data['data'];

      debugPrint('Fetched hazard details: ${data['hazard_action']}');
      final item = HazardModel.fromJson(data);
      return item;
    } catch (e) {
      debugPrint('Error fetching hazard details: $e');
      throw Exception('Failed to load hazard details: $e');
    }
  }
}

@riverpod
class GetPICList extends _$GetPICList {
  late Dio _dio;

  @override
  Future<List<PICModel>> build({required String searchName}) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(name: searchName);
  }

  Future<List<PICModel>> _fetch({required String name}) async {
    try {
      final res = await _dio.get('/pic', queryParameters: {'name': name});
      final List data = res.data['data'];
      final items = data.map((e) => PICModel.fromJson(e)).toList();
      print('Fetched PIC list: ${items.length} items');
      return items;
    } catch (e) {
      debugPrint('Error fetching PIC details: $e');
      throw Exception('Failed to load PIC details: $e');
    }
  }
}

@riverpod
class UpdateAction extends _$UpdateAction {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<(bool, String?)> setpic(Map<String, dynamic> data) async {
    try {
      final String id_hazard = data['hazard_report_id'].toString();
      final formData = FormData.fromMap({'pic': data['pic']});

      await _dio.post('/hazard/$id_hazard/pic', data: formData);

      ref.read(listHazardReportProvider(filter: 'open').notifier).refresh();
      return (true, null);
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan';
      print(e);
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        debugPrint('DioException: ${e.response}, Status code: $statusCode');
        errorMessage = getErrorMessage(statusCode ?? 0);
      }
      return (false, errorMessage);
    }
  }
}
