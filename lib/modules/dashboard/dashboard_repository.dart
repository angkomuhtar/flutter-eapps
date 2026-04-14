import 'package:dio/dio.dart';
import 'package:flutter_eapps/core/dio/dio_factory.dart';
import 'package:flutter_eapps/core/dio/dio_provider.dart';
import 'package:flutter_eapps/core/models/clock_today_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_repository.g.dart';

class DashboardRepository {
  DashboardRepository({required this.dio});
  final Dio dio;

  Future<ClockToday> get_today_clock() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final res = await dio.get('/clock/today');
      return ClockToday.fromJson(res.data['data']);
    } catch (e) {
      throw Exception('Failed to fetch today\'s attendance: $e');
    }
  }

  Future<Rekap> get_rekap() async {
    try {
      final res = await dio.get('/clock/rekap');
      return Rekap.fromJson(res.data['data']['rekap']);
    } catch (e) {
      throw Exception('Failed to fetch rekap\'s attendance: $e');
    }
  }
}

@Riverpod(keepAlive: true)
class DashboardRepositoryNotifier extends _$DashboardRepositoryNotifier {
  @override
  DashboardRepository build() {
    final dio = ref.read(dioProvider(ApiType.empapps));
    return DashboardRepository(dio: dio);
  }
}

@riverpod
class TodayAttendance extends _$TodayAttendance {
  @override
  Future<ClockToday> build() async {
    final repo = ref.read(dashboardRepositoryNotifierProvider);
    return await repo.get_today_clock();
  }
}

@riverpod
class RekapAttendance extends _$RekapAttendance {
  @override
  Future<Rekap> build() async {
    final repo = ref.read(dashboardRepositoryNotifierProvider);
    return await repo.get_rekap();
  }
}
