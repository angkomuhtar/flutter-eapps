import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_eapps/core/models/sop_model.dart';

part 'sop_provider.g.dart';

@riverpod
class ListSop extends _$ListSop {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<ListSopModel> _items = [];

  @override
  Future<List<ListSopModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.eLearn));

    return _fetch(reset: true);
  }

  Future<List<ListSopModel>> _fetch({bool reset = false}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get('/sop/sop-folders');

      final list = res.data['data'];

      final newItems = List<ListSopModel>.from(
        list.map((e) => ListSopModel.fromJson(e)),
      );

      _items.addAll(newItems);

      final currentPage = res.data['meta']['current_page'];
      final lastPage = res.data['meta']['last_page'];

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
class SopDetails extends _$SopDetails {
  late Dio _dio;

  @override
  Future<List<SopDetailsModel>> build(String id) async {
    _dio = ref.read(dioProvider(ApiType.eLearn));
    return _fetch(id);
  }

  Future<List<SopDetailsModel>> _fetch(String id) async {
    try {
      final res = await _dio.get('/sop/sop-folders/$id');
      final data = res.data['data'];
      return (data as List).map((e) => SopDetailsModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error fetching SOP details: $e');
      rethrow;
    }
  }
}
