import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/clock_today_model.dart';
import 'package:flutter_eapps/core/models/radius_model.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_provider.g.dart';

@riverpod
class Today extends _$Today {
  late Dio _dio;

  @override
  Future<ClockToday?> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<ClockToday?> _fetch() async {
    final res = await _dio.get('/clock/today');
    final data = res.data['data'];
    if (data == null) return null;

    return ClockToday.fromJson(data);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}

@riverpod
class AllowedRadius extends _$AllowedRadius {
  late Dio _dio;
  @override
  Future<List<RadiusModel>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<List<RadiusModel>> _fetch() async {
    final res = await _dio.get('/clock/location');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => RadiusModel.fromJson(e)).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}

@riverpod
class ListShift extends _$ListShift {
  late Dio _dio;
  @override
  Future<List<Shift>> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    return _fetch();
  }

  Future<List<Shift>> _fetch() async {
    final res = await _dio.get('/clock/shift');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => Shift.fromJson(e)).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}

@riverpod
class ClockInOut extends _$ClockInOut {
  late Dio _dio;
  late PackageInfo packageInfo;

  @override
  Future<void> build() async {
    _dio = ref.read(dioProvider(ApiType.empapps));
  }

  Future<void> clock_in_out({
    required String type,
    required int location,
    required int shift,
    required String date,
  }) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      await _dio.post(
        '/clock',
        data: {
          'platform': Platform.isAndroid ? 'android' : 'ios',
          'version': packageInfo.version,
          'location': location,
          'time': DateFormat('HH:mm:ss').format(DateTime.now()),
          'shift': shift,
          'date': date,
          'type': type,
        },
      );
      ref.invalidate(todayProvider);
    } catch (e) {
      // if (e is DioException) {
      // } else {
      //   print('Clock $type error: $e');
      // }
      throw e;
    }
  }
}

@riverpod
class AttHistory extends _$AttHistory {
  late Dio _dio;
  late String _date;

  @override
  Future<List<ClockToday>> build(String date) async {
    _dio = ref.read(dioProvider(ApiType.empapps));
    _date = date;
    return _fetch();
  }

  Future<List<ClockToday>> _fetch() async {
    final res = await _dio.get('/clock/$_date/history');
    final data = res.data['data'];

    if (data == null) return [];

    final List list = data is List ? data : [];
    return list.map((e) => ClockToday.fromJson(e)).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch());
  }
}
