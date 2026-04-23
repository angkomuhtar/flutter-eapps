import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/options_model.dart';
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
