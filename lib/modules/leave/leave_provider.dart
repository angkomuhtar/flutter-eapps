import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/leave_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_provider.g.dart';

@riverpod
class LeaveHistory extends _$LeaveHistory {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<ListLeaveModel> _items = [];

  @override
  Future<List<ListLeaveModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.ePkwt));
    return _fetch(reset: true);
  }

  Future<List<ListLeaveModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;

    try {
      final queryParams = <String, dynamic>{'page': _page};
      if (_filter != '') {
        queryParams['status'] = _filter;
      }

      final res = await _dio.get('/my-absences', queryParameters: queryParams);

      final data = res.data;

      final List list = data['data'];
      debugPrint('Fetched list leave history: ${list} items');

      final newItems = list.map((e) => ListLeaveModel.fromJson(e)).toList();

      _items.addAll(newItems);

      final currentPage = data['meta']['current_page'] ?? 1;
      final lastPage = data['meta']['last_page'] ?? 1;

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;

      return _items;
    } catch (e) {
      debugPrint('Error fetching leave: $e');
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
class UploadLeave extends _$UploadLeave {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.ePkwt));
  }

  Future<(bool, String?)> upload(Map<String, dynamic> data) async {
    try {
      final formData = FormData.fromMap(data);

      await _dio.post('/my-absences', data: formData);

      ref.read(leaveHistoryProvider.notifier).refresh();
      return (true, null);
    } catch (e) {
      String errorMessage = 'Terjadi kesalahan';
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        debugPrint('DioException: ${e.response}, Status code: $statusCode');
        errorMessage = e.response?.data['message'] ?? 'Terjadi kesalahan';
      }
      return (false, errorMessage);
    }
  }
}

@riverpod
class DetailLeave extends _$DetailLeave {
  late Dio _dio;

  @override
  Future<DetailLeaveModel> build({required String id}) async {
    _dio = ref.read(dioProvider(ApiType.ePkwt));
    return _fetch(id: id);
  }

  Future<DetailLeaveModel> _fetch({required String id}) async {
    try {
      final res = await _dio.get('/my-absences/$id');

      debugPrint('Fetched leave details: ${res.data['data']}');
      final data = res.data['data'];
      final item = DetailLeaveModel.fromJson(data);
      return item;
    } catch (e) {
      debugPrint('Error fetching hazard details: $e');
      throw Exception('Failed to load hazard details: $e');
    }
  }
}

@riverpod
class GetLeaveKuota extends _$GetLeaveKuota {
  late Dio _dio;

  @override
  Future<DailyLeaveKuotaModel> build(String date) async {
    _dio = ref.read(dioProvider(ApiType.ePkwt));
    return _fetch(date);
  }

  Future<DailyLeaveKuotaModel> _fetch(String date) async {
    try {
      final res = await _dio.get(
        '/my-absences/create',
        queryParameters: {'dateFrom': date},
      );
      final data = res.data;
      final result = DailyLeaveKuotaModel.fromJson(data);
      return result;
    } catch (e) {
      debugPrint('Error fetching leave kuota: $e');
      throw Exception('Failed to load leave kuota: $e');
    }
  }
}
