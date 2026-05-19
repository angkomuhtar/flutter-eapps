// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazard_report_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listHazardReportHash() => r'69b5ed6cb3923d0d43b5ab1f7f43f0c002b6dd49';

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

abstract class _$ListHazardReport
    extends BuildlessAutoDisposeAsyncNotifier<List<HazardItemModel>> {
  late final String filter;

  FutureOr<List<HazardItemModel>> build({String filter = ""});
}

/// See also [ListHazardReport].
@ProviderFor(ListHazardReport)
const listHazardReportProvider = ListHazardReportFamily();

/// See also [ListHazardReport].
class ListHazardReportFamily extends Family<AsyncValue<List<HazardItemModel>>> {
  /// See also [ListHazardReport].
  const ListHazardReportFamily();

  /// See also [ListHazardReport].
  ListHazardReportProvider call({String filter = ""}) {
    return ListHazardReportProvider(filter: filter);
  }

  @override
  ListHazardReportProvider getProviderOverride(
    covariant ListHazardReportProvider provider,
  ) {
    return call(filter: provider.filter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listHazardReportProvider';
}

/// See also [ListHazardReport].
class ListHazardReportProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ListHazardReport,
          List<HazardItemModel>
        > {
  /// See also [ListHazardReport].
  ListHazardReportProvider({String filter = ""})
    : this._internal(
        () => ListHazardReport()..filter = filter,
        from: listHazardReportProvider,
        name: r'listHazardReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listHazardReportHash,
        dependencies: ListHazardReportFamily._dependencies,
        allTransitiveDependencies:
            ListHazardReportFamily._allTransitiveDependencies,
        filter: filter,
      );

  ListHazardReportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final String filter;

  @override
  FutureOr<List<HazardItemModel>> runNotifierBuild(
    covariant ListHazardReport notifier,
  ) {
    return notifier.build(filter: filter);
  }

  @override
  Override overrideWith(ListHazardReport Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListHazardReportProvider._internal(
        () => create()..filter = filter,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ListHazardReport,
    List<HazardItemModel>
  >
  createElement() {
    return _ListHazardReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListHazardReportProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListHazardReportRef
    on AutoDisposeAsyncNotifierProviderRef<List<HazardItemModel>> {
  /// The parameter `filter` of this provider.
  String get filter;
}

class _ListHazardReportProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ListHazardReport,
          List<HazardItemModel>
        >
    with ListHazardReportRef {
  _ListHazardReportProviderElement(super.provider);

  @override
  String get filter => (origin as ListHazardReportProvider).filter;
}

String _$detailHazardReportHash() =>
    r'f57d6e551e0df63f8382b34193cf87771c6ccbb5';

abstract class _$DetailHazardReport
    extends BuildlessAutoDisposeAsyncNotifier<HazardModel> {
  late final String id;

  FutureOr<HazardModel> build({required String id});
}

/// See also [DetailHazardReport].
@ProviderFor(DetailHazardReport)
const detailHazardReportProvider = DetailHazardReportFamily();

/// See also [DetailHazardReport].
class DetailHazardReportFamily extends Family<AsyncValue<HazardModel>> {
  /// See also [DetailHazardReport].
  const DetailHazardReportFamily();

  /// See also [DetailHazardReport].
  DetailHazardReportProvider call({required String id}) {
    return DetailHazardReportProvider(id: id);
  }

  @override
  DetailHazardReportProvider getProviderOverride(
    covariant DetailHazardReportProvider provider,
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
  String? get name => r'detailHazardReportProvider';
}

/// See also [DetailHazardReport].
class DetailHazardReportProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<DetailHazardReport, HazardModel> {
  /// See also [DetailHazardReport].
  DetailHazardReportProvider({required String id})
    : this._internal(
        () => DetailHazardReport()..id = id,
        from: detailHazardReportProvider,
        name: r'detailHazardReportProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailHazardReportHash,
        dependencies: DetailHazardReportFamily._dependencies,
        allTransitiveDependencies:
            DetailHazardReportFamily._allTransitiveDependencies,
        id: id,
      );

  DetailHazardReportProvider._internal(
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
  FutureOr<HazardModel> runNotifierBuild(
    covariant DetailHazardReport notifier,
  ) {
    return notifier.build(id: id);
  }

  @override
  Override overrideWith(DetailHazardReport Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailHazardReportProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DetailHazardReport, HazardModel>
  createElement() {
    return _DetailHazardReportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailHazardReportProvider && other.id == id;
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
mixin DetailHazardReportRef
    on AutoDisposeAsyncNotifierProviderRef<HazardModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DetailHazardReportProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<DetailHazardReport, HazardModel>
    with DetailHazardReportRef {
  _DetailHazardReportProviderElement(super.provider);

  @override
  String get id => (origin as DetailHazardReportProvider).id;
}

String _$getPICListHash() => r'614bd730beddf978229775092df3f6faa8ee3c36';

abstract class _$GetPICList
    extends BuildlessAutoDisposeAsyncNotifier<List<PICModel>> {
  late final String searchName;

  FutureOr<List<PICModel>> build({required String searchName});
}

/// See also [GetPICList].
@ProviderFor(GetPICList)
const getPICListProvider = GetPICListFamily();

/// See also [GetPICList].
class GetPICListFamily extends Family<AsyncValue<List<PICModel>>> {
  /// See also [GetPICList].
  const GetPICListFamily();

  /// See also [GetPICList].
  GetPICListProvider call({required String searchName}) {
    return GetPICListProvider(searchName: searchName);
  }

  @override
  GetPICListProvider getProviderOverride(
    covariant GetPICListProvider provider,
  ) {
    return call(searchName: provider.searchName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPICListProvider';
}

/// See also [GetPICList].
class GetPICListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetPICList, List<PICModel>> {
  /// See also [GetPICList].
  GetPICListProvider({required String searchName})
    : this._internal(
        () => GetPICList()..searchName = searchName,
        from: getPICListProvider,
        name: r'getPICListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getPICListHash,
        dependencies: GetPICListFamily._dependencies,
        allTransitiveDependencies: GetPICListFamily._allTransitiveDependencies,
        searchName: searchName,
      );

  GetPICListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchName,
  }) : super.internal();

  final String searchName;

  @override
  FutureOr<List<PICModel>> runNotifierBuild(covariant GetPICList notifier) {
    return notifier.build(searchName: searchName);
  }

  @override
  Override overrideWith(GetPICList Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetPICListProvider._internal(
        () => create()..searchName = searchName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchName: searchName,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetPICList, List<PICModel>>
  createElement() {
    return _GetPICListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPICListProvider && other.searchName == searchName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPICListRef on AutoDisposeAsyncNotifierProviderRef<List<PICModel>> {
  /// The parameter `searchName` of this provider.
  String get searchName;
}

class _GetPICListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GetPICList, List<PICModel>>
    with GetPICListRef {
  _GetPICListProviderElement(super.provider);

  @override
  String get searchName => (origin as GetPICListProvider).searchName;
}

String _$updateActionHash() => r'32b3fcecdb0001f5a2429c50bb1a042ae4061843';

/// See also [UpdateAction].
@ProviderFor(UpdateAction)
final updateActionProvider =
    AutoDisposeAsyncNotifierProvider<UpdateAction, void>.internal(
      UpdateAction.new,
      name: r'updateActionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateActionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UpdateAction = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
