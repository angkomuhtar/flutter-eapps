import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/contract_model.dart';
import 'package:flutter_eapps/core/models/hazard_model.dart';
import 'package:flutter_eapps/core/utils/app.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
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
    final user = ref.read(currentUserProvider).valueOrNull;
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

      final newItems = list.map((e) => ContractModel.fromJson(e)).toList();

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
// @riverpod
// class UploadHazard extends _$UploadHazard {
//   late final Dio _dio;

//   @override
//   FutureOr<void> build() {
//     _dio = ref.read(dioProvider(ApiType.empapps));
//   }

//   Future<(bool, String?)> upload(Map<String, dynamic> data) async {
//     try {
//       final image = data['report_attachment'] as File;
//       final fileName = image.path.split('/').last;
//       final formData = FormData.fromMap({
//         ...data,
//         'report_attachment': await MultipartFile.fromFile(
//           image.path,
//           filename: fileName,
//         ),
//       });

//       await _dio.post('/hazard', data: formData);

//       ref.read(listHazardProvider.notifier).refresh();
//       return (true, null);
//     } catch (e) {
//       String errorMessage = 'Terjadi kesalahan';
//       if (e is DioException) {
//         final statusCode = e.response?.statusCode;
//         debugPrint('DioException: ${e.response}, Status code: $statusCode');
//         errorMessage = getErrorMessage(statusCode ?? 0);
//       }
//       return (false, errorMessage);
//     }
//   }
// }

// @riverpod
// class DetailHazard extends _$DetailHazard {
//   late Dio _dio;

//   @override
//   Future<HazardModel> build({required String id}) async {
//     _dio = ref.read(dioProvider(ApiType.empapps));
//     return _fetch(id: id);
//   }

//   Future<HazardModel> _fetch({required String id}) async {
//     try {
//       final res = await _dio.get('/hazard/$id');

//       final data = res.data['data'];
//       final item = HazardModel.fromJson(data);
//       return item;
//     } catch (e) {
//       debugPrint('Error fetching hazard details: $e');
//       throw Exception('Failed to load hazard details: $e');
//     }
//   }
// }
