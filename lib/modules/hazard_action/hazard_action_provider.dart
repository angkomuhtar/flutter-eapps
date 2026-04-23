import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hazard_action_provider.g.dart';

@riverpod
class ListHazardAction extends _$ListHazardAction {
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
        '/hazard/action',
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
      debugPrint('Error fetching hazard actions: $e');
    }
    return _items;
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
class UpdateAction extends _$UpdateAction {
  late final Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<(bool, String?)> upload(Map<String, dynamic> data) async {
    try {
      final image = data['action_attachment'] as File;
      final fileName = image.path.split('/').last;
      final formData = FormData.fromMap({
        ...data,
        'action_attachment': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      await _dio.post('/hazard/action', data: formData);

      ref.read(listHazardActionProvider().notifier).refresh();
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
class DetailHazardAction extends _$DetailHazardAction {
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
