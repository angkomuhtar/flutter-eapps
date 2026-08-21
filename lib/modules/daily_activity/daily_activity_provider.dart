import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/daily_activity_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_activity_provider.g.dart';

@riverpod
class ListActivity extends _$ListActivity {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<DailyActivityModel> _items = [];

  @override
  Future<List<DailyActivityModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(reset: true);
  }

  Future<List<DailyActivityModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get(
        '/daily_activity',
        queryParameters: {'page': _page},
      );

      final data = res.data['data'];

      final List list = data['data'];

      final newItems = list.map((e) {
        return DailyActivityModel.fromJson(e);
      }).toList();

      _items.addAll(newItems);

      final currentPage = data['current_page'];
      final lastPage = data['last_page'];

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;

      return _items;
    } catch (e) {
      debugPrint('Error fetching data: $e');
      throw Exception('Failed to load hazard details: $e');
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
class SaveActivity extends _$SaveActivity {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<(bool, String?)> save(Map<String, dynamic> data) async {
    try {
      // final String id_hazard = data['hazard_report_id'].toString();
      // final formData = FormData.fromMap({'pic': data['pic']});

      await _dio.post('/daily_activity', data: data);

      // ref.read(listHazardReportProvider(filter: 'open').notifier).refresh();
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
