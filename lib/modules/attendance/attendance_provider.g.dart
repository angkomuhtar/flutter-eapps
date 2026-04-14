// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayHash() => r'85ef4145f560622cd2d0582aae998c55d71f3bec';

/// See also [Today].
@ProviderFor(Today)
final todayProvider =
    AutoDisposeAsyncNotifierProvider<Today, ClockToday?>.internal(
      Today.new,
      name: r'todayProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Today = AutoDisposeAsyncNotifier<ClockToday?>;
String _$allowedRadiusHash() => r'ea269a2203f29d87a781579d8c58b65a40cb56c5';

/// See also [AllowedRadius].
@ProviderFor(AllowedRadius)
final allowedRadiusProvider =
    AutoDisposeAsyncNotifierProvider<AllowedRadius, List<RadiusModel>>.internal(
      AllowedRadius.new,
      name: r'allowedRadiusProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allowedRadiusHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AllowedRadius = AutoDisposeAsyncNotifier<List<RadiusModel>>;
String _$listShiftHash() => r'032ecd05098189bb04a9ba34fb4a6b4f38368e73';

/// See also [ListShift].
@ProviderFor(ListShift)
final listShiftProvider =
    AutoDisposeAsyncNotifierProvider<ListShift, List<Shift>>.internal(
      ListShift.new,
      name: r'listShiftProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listShiftHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListShift = AutoDisposeAsyncNotifier<List<Shift>>;
String _$clockInOutHash() => r'398e3497cd7f04ac2254da38fca7ea1b59e29121';

/// See also [ClockInOut].
@ProviderFor(ClockInOut)
final clockInOutProvider =
    AutoDisposeAsyncNotifierProvider<ClockInOut, void>.internal(
      ClockInOut.new,
      name: r'clockInOutProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$clockInOutHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClockInOut = AutoDisposeAsyncNotifier<void>;
String _$attHistoryHash() => r'4a53523b818aaa49a4af391c5483d9ff7424285f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AttHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<ClockToday>> {
  late final String date;

  FutureOr<List<ClockToday>> build(String date);
}

/// See also [AttHistory].
@ProviderFor(AttHistory)
const attHistoryProvider = AttHistoryFamily();

/// See also [AttHistory].
class AttHistoryFamily extends Family<AsyncValue<List<ClockToday>>> {
  /// See also [AttHistory].
  const AttHistoryFamily();

  /// See also [AttHistory].
  AttHistoryProvider call(String date) {
    return AttHistoryProvider(date);
  }

  @override
  AttHistoryProvider getProviderOverride(
    covariant AttHistoryProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attHistoryProvider';
}

/// See also [AttHistory].
class AttHistoryProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AttHistory, List<ClockToday>> {
  /// See also [AttHistory].
  AttHistoryProvider(String date)
    : this._internal(
        () => AttHistory()..date = date,
        from: attHistoryProvider,
        name: r'attHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$attHistoryHash,
        dependencies: AttHistoryFamily._dependencies,
        allTransitiveDependencies: AttHistoryFamily._allTransitiveDependencies,
        date: date,
      );

  AttHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final String date;

  @override
  FutureOr<List<ClockToday>> runNotifierBuild(covariant AttHistory notifier) {
    return notifier.build(date);
  }

  @override
  Override overrideWith(AttHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttHistoryProvider._internal(
        () => create()..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AttHistory, List<ClockToday>>
  createElement() {
    return _AttHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttHistoryProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttHistoryRef on AutoDisposeAsyncNotifierProviderRef<List<ClockToday>> {
  /// The parameter `date` of this provider.
  String get date;
}

class _AttHistoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<AttHistory, List<ClockToday>>
    with AttHistoryRef {
  _AttHistoryProviderElement(super.provider);

  @override
  String get date => (origin as AttHistoryProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
