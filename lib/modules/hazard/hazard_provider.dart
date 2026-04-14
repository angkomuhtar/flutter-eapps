import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/core/models/sleep_duration_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_repository.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_provider.g.dart';

@riverpod
class ListHazard extends _$ListHazard {
  late Dio _dio;

  int _page = 1;
  bool _hasMore = true;
  final List<HazardModel> _items = [];

  @override
  Future<List<HazardModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(reset: true);
  }

  Future<List<HazardModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;

    final res = await _dio.get('/hazard', queryParameters: {'page': _page});

    final data = res.data['data'];

    final List list = data['data'];

    final newItems = list.map((e) => HazardModel.fromJson(e)).toList();

    _items.addAll(newItems);

    final currentPage = data['current_page'];
    final lastPage = data['last_page'];

    _hasMore = currentPage < lastPage;

    if (_hasMore) _page++;

    return _items;
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;

    state = await AsyncValue.guard(() async {
      return await _fetch();
    });
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _fetch(reset: true);
    });
  }
}

@riverpod
class UploadHazard extends _$UploadHazard {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<(bool, String?)> upload({
    required int hour,
    required int minute,
    required File image,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final fileName = image.path.split('/').last;
      final end = DateFormat('yyyy-MM-dd 06:00:00').format(DateTime.now());
      final start = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        DateTime.parse(end).subtract(Duration(hours: hour, minutes: minute)),
      );
      final formData = FormData.fromMap({
        'stage': 0,
        'start': start,
        'end': end,
        'attachment': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      await _dio.post('/hazard', data: formData);
    });

    if (state.hasError) {
      final error = state.error;
      String errorMessage = 'Terjadi kesalahan';
      if (error is DioException) {
        final statusCode = error.response?.statusCode;
        debugPrint('DioException: ${error.response}, Status code: $statusCode');
        errorMessage = getErrorMessage(statusCode ?? 0);
      }
      return (false, errorMessage);
    }

    ref.read(listHazardProvider.notifier).refresh();
    ref.invalidate(todayAttendanceProvider);
    return (true, null);
  }
}
