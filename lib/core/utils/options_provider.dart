import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/options_model.dart';
import 'package:flutter_eapps/core/models/units_model.dart';
import 'package:flutter_eapps/core/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'options_provider.g.dart';

@riverpod
class ListHazardLocation extends _$ListHazardLocation {
  late Dio _dio;
  @override
  Future<List<HazardLocationModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<List<HazardLocationModel>> _fetch() async {
    final res = await _dio.get('/master/hazard_location');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => HazardLocationModel.fromJson(e)).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}

@riverpod
class ListCompany extends _$ListCompany {
  late Dio _dio;
  @override
  Future<List<CompanyModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<List<CompanyModel>> _fetch() async {
    final res = await _dio.get('/master/company');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => CompanyModel.fromJson(e)).toList();
  }
}

@riverpod
class ListProject extends _$ListProject {
  late Dio _dio;
  @override
  Future<List<ProjectModel>> build(String companyId) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(companyId);
  }

  Future<List<ProjectModel>> _fetch(String companyId) async {
    final res = await _dio.get('/master/project/${companyId}');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => ProjectModel.fromJson(e)).toList();
  }
}

@riverpod
class ListDepartement extends _$ListDepartement {
  late Dio _dio;
  @override
  Future<List<DepartementModel>> build(String companyId) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch(companyId);
  }

  Future<List<DepartementModel>> _fetch(String companyId) async {
    final res = await _dio.get('/master/division/${companyId}');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => DepartementModel.fromJson(e)).toList();
  }
}

@riverpod
class UserLoginData extends _$UserLoginData {
  late Dio _dio;
  @override
  Future<UserModel?> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<UserModel?> _fetch() async {
    final res = await _dio.get('/me');
    final data = res.data['user'];
    if (data == null) return null;
    return UserModel.fromJson(data);
  }
}

@riverpod
class GetVersionData extends _$GetVersionData {
  late Dio _dio;
  @override
  Future<VersionModel> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<VersionModel> _fetch() async {
    try {
      final res = await _dio.get(
        '/version',
        queryParameters: {'device': Platform.isAndroid ? 'ANDROID' : 'IOS'},
      );
      print(res.data['data']);
      final data = res.data['data'];
      return VersionModel.fromJson(data);
    } catch (e) {
      debugPrint('Error fetching VERSION: $e');
      throw Exception('Failed to LOAD VERSION: $e');
    }
  }
}

@riverpod
class GetUnitList extends _$GetUnitList {
  late Dio _dio;

  @override
  Future<List<UnitsModel>> build({
    required String searchQuery,
    int category = 0,
  }) async {
    _dio = ref.read(dioProvider(ApiType.p2h));
    return _fetch(
      query: searchQuery,
      category: category == 0 ? '' : category.toString(),
    );
  }

  Future<List<UnitsModel>> _fetch({
    required String query,
    required String category,
  }) async {
    try {
      final res = await _dio.get(
        'units',
        queryParameters: {'query': query, 'category': category},
      );
      final List data = res.data['data'];
      // print(data);
      final items = data.map((e) {
        print('err :');
        print(e);

        return UnitsModel.fromJson(e);
      }).toList();
      print('Fetched PIC list: ${items.length} items');
      return items;
    } catch (e) {
      debugPrint('Error fetching PIC details: $e');
      throw Exception('Failed to load PIC details: $e');
    }
  }
}

@riverpod
class GetUnitCategory extends _$GetUnitCategory {
  late Dio _dio;

  @override
  Future<List<UnitCategoryModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.p2h));
    return _fetch();
  }

  Future<List<UnitCategoryModel>> _fetch() async {
    try {
      final res = await _dio.get('units/category');
      final List data = res.data['data'];
      // print(data);
      final items = data.map((e) {
        print('err :');
        print(e);

        return UnitCategoryModel.fromJson(e);
      }).toList();
      print('Fetched PIC list: ${items.length} items');
      return items;
    } catch (e) {
      debugPrint('Error fetching category: $e');
      throw Exception('Failed to load category: $e');
    }
  }
}
