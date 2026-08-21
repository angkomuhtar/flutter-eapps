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

String _$userLoginDataHash() => r'3f097dd244ec2bce4a3ed614284278869a113456';

/// See also [UserLoginData].
@ProviderFor(UserLoginData)
final userLoginDataProvider =
    AutoDisposeAsyncNotifierProvider<UserLoginData, UserModel?>.internal(
      UserLoginData.new,
      name: r'userLoginDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userLoginDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserLoginData = AutoDisposeAsyncNotifier<UserModel?>;
String _$getVersionDataHash() => r'6a9c6a8448dcec318c987b1c8e1149e22f950eec';

/// See also [GetVersionData].
@ProviderFor(GetVersionData)
final getVersionDataProvider =
    AutoDisposeAsyncNotifierProvider<GetVersionData, VersionModel>.internal(
      GetVersionData.new,
      name: r'getVersionDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getVersionDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GetVersionData = AutoDisposeAsyncNotifier<VersionModel>;
String _$getUnitListHash() => r'3de8eb573410a4696684fe9fc06ad06fc1ab2c07';

abstract class _$GetUnitList
    extends BuildlessAutoDisposeAsyncNotifier<List<UnitsModel>> {
  late final String searchQuery;
  late final int category;

  FutureOr<List<UnitsModel>> build({
    required String searchQuery,
    int category = 0,
  });
}

/// See also [GetUnitList].
@ProviderFor(GetUnitList)
const getUnitListProvider = GetUnitListFamily();

/// See also [GetUnitList].
class GetUnitListFamily extends Family<AsyncValue<List<UnitsModel>>> {
  /// See also [GetUnitList].
  const GetUnitListFamily();

  /// See also [GetUnitList].
  GetUnitListProvider call({required String searchQuery, int category = 0}) {
    return GetUnitListProvider(searchQuery: searchQuery, category: category);
  }

  @override
  GetUnitListProvider getProviderOverride(
    covariant GetUnitListProvider provider,
  ) {
    return call(searchQuery: provider.searchQuery, category: provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUnitListProvider';
}

/// See also [GetUnitList].
class GetUnitListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<GetUnitList, List<UnitsModel>> {
  /// See also [GetUnitList].
  GetUnitListProvider({required String searchQuery, int category = 0})
    : this._internal(
        () => GetUnitList()
          ..searchQuery = searchQuery
          ..category = category,
        from: getUnitListProvider,
        name: r'getUnitListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getUnitListHash,
        dependencies: GetUnitListFamily._dependencies,
        allTransitiveDependencies: GetUnitListFamily._allTransitiveDependencies,
        searchQuery: searchQuery,
        category: category,
      );

  GetUnitListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchQuery,
    required this.category,
  }) : super.internal();

  final String searchQuery;
  final int category;

  @override
  FutureOr<List<UnitsModel>> runNotifierBuild(covariant GetUnitList notifier) {
    return notifier.build(searchQuery: searchQuery, category: category);
  }

  @override
  Override overrideWith(GetUnitList Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetUnitListProvider._internal(
        () => create()
          ..searchQuery = searchQuery
          ..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchQuery: searchQuery,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetUnitList, List<UnitsModel>>
  createElement() {
    return _GetUnitListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUnitListProvider &&
        other.searchQuery == searchQuery &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchQuery.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetUnitListRef on AutoDisposeAsyncNotifierProviderRef<List<UnitsModel>> {
  /// The parameter `searchQuery` of this provider.
  String get searchQuery;

  /// The parameter `category` of this provider.
  int get category;
}

class _GetUnitListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<GetUnitList, List<UnitsModel>>
    with GetUnitListRef {
  _GetUnitListProviderElement(super.provider);

  @override
  String get searchQuery => (origin as GetUnitListProvider).searchQuery;
  @override
  int get category => (origin as GetUnitListProvider).category;
}

String _$getUnitCategoryHash() => r'51908459347e89db329cfe283453a682db203022';

/// See also [GetUnitCategory].
@ProviderFor(GetUnitCategory)
final getUnitCategoryProvider =
    AutoDisposeAsyncNotifierProvider<
      GetUnitCategory,
      List<UnitCategoryModel>
    >.internal(
      GetUnitCategory.new,
      name: r'getUnitCategoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getUnitCategoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GetUnitCategory = AutoDisposeAsyncNotifier<List<UnitCategoryModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
