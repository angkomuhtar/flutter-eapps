import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/contract_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/core/utils/options_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pkwt_provider.g.dart';

@riverpod
class ListContract extends _$ListContract {
  late Dio _dio;

  int _page = 1;
  String _filter = "";
  bool _hasMore = true;
  final List<ContractModel> _items = [];

  @override
  Future<List<ContractModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.ePkwt));

    return _fetch(reset: true);
  }

  Future<List<ContractModel>> _fetch({bool reset = false}) async {
    final user = ref.read(userLoginDataProvider).valueOrNull;
    if (reset) {
      _page = 1;
      _hasMore = true;
      _items.clear();
    }

    if (!_hasMore) return _items;
    try {
      final res = await _dio.get(
        '/list-contracts',
        queryParameters: {'page': _page, 'user_id': user?.id},
      );

      final data = res.data['data'];

      final List list = data['data'];

      final newItems = list.map((e) {
        print(e);
        return ContractModel.fromJson(e);
      }).toList();

      _items.addAll(newItems);

      final currentPage = data['current_page'];
      final lastPage = data['last_page'];

      _hasMore = currentPage < lastPage;

      if (_hasMore) _page++;

      return _items;
    } catch (e) {
      debugPrint('Error fetching kontrak: $e');
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
class SignedContract extends _$SignedContract {
  late Dio _dio;

  @override
  FutureOr<void> build() {
    _dio = ref.read(dioProvider(ApiType.ePkwt));
  }

  Future<(bool, String?)> sign(Map<String, dynamic> data) async {
    try {
      await _dio.post('/signed-contracts', data: data);

      ref.read(listContractProvider.notifier).refresh();
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
