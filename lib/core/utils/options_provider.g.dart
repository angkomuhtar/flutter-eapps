// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listHazardLocationHash() =>
    r'dd689da6ab509094107c6592bc7b2bc3f61bcdea';

/// See also [ListHazardLocation].
@ProviderFor(ListHazardLocation)
final listHazardLocationProvider =
    AutoDisposeAsyncNotifierProvider<
      ListHazardLocation,
      List<HazardLocationModel>
    >.internal(
      ListHazardLocation.new,
      name: r'listHazardLocationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listHazardLocationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListHazardLocation =
    AutoDisposeAsyncNotifier<List<HazardLocationModel>>;
String _$listCompanyHash() => r'698cbab8c8c2f21127d8883da3122e0ef20743a1';

/// See also [ListCompany].
@ProviderFor(ListCompany)
final listCompanyProvider =
    AutoDisposeAsyncNotifierProvider<ListCompany, List<CompanyModel>>.internal(
      ListCompany.new,
      name: r'listCompanyProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listCompanyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListCompany = AutoDisposeAsyncNotifier<List<CompanyModel>>;
String _$listProjectHash() => r'0eb85a638940f0b5b90afc434bef4d56ac5e430e';

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

abstract class _$ListProject
    extends BuildlessAutoDisposeAsyncNotifier<List<ProjectModel>> {
  late final String companyId;

  FutureOr<List<ProjectModel>> build(String companyId);
}

/// See also [ListProject].
@ProviderFor(ListProject)
const listProjectProvider = ListProjectFamily();

/// See also [ListProject].
class ListProjectFamily extends Family<AsyncValue<List<ProjectModel>>> {
  /// See also [ListProject].
  const ListProjectFamily();

  /// See also [ListProject].
  ListProjectProvider call(String companyId) {
    return ListProjectProvider(companyId);
  }

  @override
  ListProjectProvider getProviderOverride(
    covariant ListProjectProvider provider,
  ) {
    return call(provider.companyId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listProjectProvider';
}

/// See also [ListProject].
class ListProjectProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ListProject, List<ProjectModel>> {
  /// See also [ListProject].
  ListProjectProvider(String companyId)
    : this._internal(
        () => ListProject()..companyId = companyId,
        from: listProjectProvider,
        name: r'listProjectProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listProjectHash,
        dependencies: ListProjectFamily._dependencies,
        allTransitiveDependencies: ListProjectFamily._allTransitiveDependencies,
        companyId: companyId,
      );

  ListProjectProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  FutureOr<List<ProjectModel>> runNotifierBuild(
    covariant ListProject notifier,
  ) {
    return notifier.build(companyId);
  }

  @override
  Override overrideWith(ListProject Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListProjectProvider._internal(
        () => create()..companyId = companyId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ListProject, List<ProjectModel>>
  createElement() {
    return _ListProjectProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListProjectProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListProjectRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProjectModel>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _ListProjectProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ListProject, List<ProjectModel>>
    with ListProjectRef {
  _ListProjectProviderElement(super.provider);

  @override
  String get companyId => (origin as ListProjectProvider).companyId;
}

String _$listDepartementHash() => r'03857303f86f840c2f9168632f0d7f10cc7af7ae';

abstract class _$ListDepartement
    extends BuildlessAutoDisposeAsyncNotifier<List<DepartementModel>> {
  late final String companyId;

  FutureOr<List<DepartementModel>> build(String companyId);
}

/// See also [ListDepartement].
@ProviderFor(ListDepartement)
const listDepartementProvider = ListDepartementFamily();

/// See also [ListDepartement].
class ListDepartementFamily extends Family<AsyncValue<List<DepartementModel>>> {
  /// See also [ListDepartement].
  const ListDepartementFamily();

  /// See also [ListDepartement].
  ListDepartementProvider call(String companyId) {
    return ListDepartementProvider(companyId);
  }

  @override
  ListDepartementProvider getProviderOverride(
    covariant ListDepartementProvider provider,
  ) {
    return call(provider.companyId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listDepartementProvider';
}

/// See also [ListDepartement].
class ListDepartementProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ListDepartement,
          List<DepartementModel>
        > {
  /// See also [ListDepartement].
  ListDepartementProvider(String companyId)
    : this._internal(
        () => ListDepartement()..companyId = companyId,
        from: listDepartementProvider,
        name: r'listDepartementProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listDepartementHash,
        dependencies: ListDepartementFamily._dependencies,
        allTransitiveDependencies:
            ListDepartementFamily._allTransitiveDependencies,
        companyId: companyId,
      );

  ListDepartementProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.companyId,
  }) : super.internal();

  final String companyId;

  @override
  FutureOr<List<DepartementModel>> runNotifierBuild(
    covariant ListDepartement notifier,
  ) {
    return notifier.build(companyId);
  }

  @override
  Override overrideWith(ListDepartement Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListDepartementProvider._internal(
        () => create()..companyId = companyId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        companyId: companyId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ListDepartement,
    List<DepartementModel>
  >
  createElement() {
    return _ListDepartementProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListDepartementProvider && other.companyId == companyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, companyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListDepartementRef
    on AutoDisposeAsyncNotifierProviderRef<List<DepartementModel>> {
  /// The parameter `companyId` of this provider.
  String get companyId;
}

class _ListDepartementProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ListDepartement,
          List<DepartementModel>
        >
    with ListDepartementRef {
  _ListDepartementProviderElement(super.provider);

  @override
  String get companyId => (origin as ListDepartementProvider).companyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
