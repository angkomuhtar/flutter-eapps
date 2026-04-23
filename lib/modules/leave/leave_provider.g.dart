// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leaveHistoryHash() => r'313795508ff3a10d60cca97a24aca0226d7f175d';

/// See also [LeaveHistory].
@ProviderFor(LeaveHistory)
final leaveHistoryProvider =
    AutoDisposeAsyncNotifierProvider<
      LeaveHistory,
      List<ListLeaveModel>
    >.internal(
      LeaveHistory.new,
      name: r'leaveHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$leaveHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LeaveHistory = AutoDisposeAsyncNotifier<List<ListLeaveModel>>;
String _$uploadLeaveHash() => r'35e6847e6d57117dc38ae70bd9b325d066de961d';

/// See also [UploadLeave].
@ProviderFor(UploadLeave)
final uploadLeaveProvider =
    AutoDisposeAsyncNotifierProvider<UploadLeave, void>.internal(
      UploadLeave.new,
      name: r'uploadLeaveProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uploadLeaveHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UploadLeave = AutoDisposeAsyncNotifier<void>;
String _$detailLeaveHash() => r'833e770ed78bcc6f79ff00433ef1807bbfce7ac7';

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

abstract class _$DetailLeave
    extends BuildlessAutoDisposeAsyncNotifier<DetailLeaveModel> {
  late final String id;

  FutureOr<DetailLeaveModel> build({required String id});
}

/// See also [DetailLeave].
@ProviderFor(DetailLeave)
const detailLeaveProvider = DetailLeaveFamily();

/// See also [DetailLeave].
class DetailLeaveFamily extends Family<AsyncValue<DetailLeaveModel>> {
  /// See also [DetailLeave].
  const DetailLeaveFamily();

  /// See also [DetailLeave].
  DetailLeaveProvider call({required String id}) {
    return DetailLeaveProvider(id: id);
  }

  @override
  DetailLeaveProvider getProviderOverride(
    covariant DetailLeaveProvider provider,
  ) {
    return call(id: provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'detailLeaveProvider';
}

/// See also [DetailLeave].
class DetailLeaveProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<DetailLeave, DetailLeaveModel> {
  /// See also [DetailLeave].
  DetailLeaveProvider({required String id})
    : this._internal(
        () => DetailLeave()..id = id,
        from: detailLeaveProvider,
        name: r'detailLeaveProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailLeaveHash,
        dependencies: DetailLeaveFamily._dependencies,
        allTransitiveDependencies: DetailLeaveFamily._allTransitiveDependencies,
        id: id,
      );

  DetailLeaveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<DetailLeaveModel> runNotifierBuild(covariant DetailLeave notifier) {
    return notifier.build(id: id);
  }

  @override
  Override overrideWith(DetailLeave Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailLeaveProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DetailLeave, DetailLeaveModel>
  createElement() {
    return _DetailLeaveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailLeaveProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DetailLeaveRef on AutoDisposeAsyncNotifierProviderRef<DetailLeaveModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DetailLeaveProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<DetailLeave, DetailLeaveModel>
    with DetailLeaveRef {
  _DetailLeaveProviderElement(super.provider);

  @override
  String get id => (origin as DetailLeaveProvider).id;
}

String _$getLeaveKuotaHash() => r'325e361d514764a78871a4e09ea2be3b606113fc';

abstract class _$GetLeaveKuota
    extends BuildlessAutoDisposeAsyncNotifier<DailyLeaveKuotaModel> {
  late final String date;

  FutureOr<DailyLeaveKuotaModel> build(String date);
}

/// See also [GetLeaveKuota].
@ProviderFor(GetLeaveKuota)
const getLeaveKuotaProvider = GetLeaveKuotaFamily();

/// See also [GetLeaveKuota].
class GetLeaveKuotaFamily extends Family<AsyncValue<DailyLeaveKuotaModel>> {
  /// See also [GetLeaveKuota].
  const GetLeaveKuotaFamily();

  /// See also [GetLeaveKuota].
  GetLeaveKuotaProvider call(String date) {
    return GetLeaveKuotaProvider(date);
  }

  @override
  GetLeaveKuotaProvider getProviderOverride(
    covariant GetLeaveKuotaProvider provider,
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
  String? get name => r'getLeaveKuotaProvider';
}

/// See also [GetLeaveKuota].
class GetLeaveKuotaProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GetLeaveKuota,
          DailyLeaveKuotaModel
        > {
  /// See also [GetLeaveKuota].
  GetLeaveKuotaProvider(String date)
    : this._internal(
        () => GetLeaveKuota()..date = date,
        from: getLeaveKuotaProvider,
        name: r'getLeaveKuotaProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getLeaveKuotaHash,
        dependencies: GetLeaveKuotaFamily._dependencies,
        allTransitiveDependencies:
            GetLeaveKuotaFamily._allTransitiveDependencies,
        date: date,
      );

  GetLeaveKuotaProvider._internal(
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
  FutureOr<DailyLeaveKuotaModel> runNotifierBuild(
    covariant GetLeaveKuota notifier,
  ) {
    return notifier.build(date);
  }

  @override
  Override overrideWith(GetLeaveKuota Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetLeaveKuotaProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<GetLeaveKuota, DailyLeaveKuotaModel>
  createElement() {
    return _GetLeaveKuotaProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLeaveKuotaProvider && other.date == date;
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
mixin GetLeaveKuotaRef
    on AutoDisposeAsyncNotifierProviderRef<DailyLeaveKuotaModel> {
  /// The parameter `date` of this provider.
  String get date;
}

class _GetLeaveKuotaProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GetLeaveKuota,
          DailyLeaveKuotaModel
        >
    with GetLeaveKuotaRef {
  _GetLeaveKuotaProviderElement(super.provider);

  @override
  String get date => (origin as GetLeaveKuotaProvider).date;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
