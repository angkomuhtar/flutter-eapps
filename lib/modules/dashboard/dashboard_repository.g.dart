// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardRepositoryNotifierHash() =>
    r'ec1350ba93d4a948647d8932b687a0fb947ec749';

/// See also [DashboardRepositoryNotifier].
@ProviderFor(DashboardRepositoryNotifier)
final dashboardRepositoryNotifierProvider =
    NotifierProvider<DashboardRepositoryNotifier, DashboardRepository>.internal(
      DashboardRepositoryNotifier.new,
      name: r'dashboardRepositoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dashboardRepositoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DashboardRepositoryNotifier = Notifier<DashboardRepository>;
String _$todayAttendanceHash() => r'1f34b4d00b7d04dc6525f04aea5185faf933d243';

/// See also [TodayAttendance].
@ProviderFor(TodayAttendance)
final todayAttendanceProvider =
    AutoDisposeAsyncNotifierProvider<TodayAttendance, ClockToday>.internal(
      TodayAttendance.new,
      name: r'todayAttendanceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayAttendanceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodayAttendance = AutoDisposeAsyncNotifier<ClockToday>;
String _$rekapAttendanceHash() => r'084776a46f033e6da20ee006fb22b45da603e8d0';

/// See also [RekapAttendance].
@ProviderFor(RekapAttendance)
final rekapAttendanceProvider =
    AutoDisposeAsyncNotifierProvider<RekapAttendance, Rekap>.internal(
      RekapAttendance.new,
      name: r'rekapAttendanceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$rekapAttendanceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RekapAttendance = AutoDisposeAsyncNotifier<Rekap>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
