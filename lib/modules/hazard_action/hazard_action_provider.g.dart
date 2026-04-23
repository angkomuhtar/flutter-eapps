// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazard_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listHazardActionHash() => r'eddc3adcd92fb90313851797bee4ec7e5d3fc9a7';

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

abstract class _$ListHazardAction
    extends BuildlessAutoDisposeAsyncNotifier<List<HazardItemModel>> {
  late final String filter;

  FutureOr<List<HazardItemModel>> build({String filter = ""});
}

/// See also [ListHazardAction].
@ProviderFor(ListHazardAction)
const listHazardActionProvider = ListHazardActionFamily();

/// See also [ListHazardAction].
class ListHazardActionFamily extends Family<AsyncValue<List<HazardItemModel>>> {
  /// See also [ListHazardAction].
  const ListHazardActionFamily();

  /// See also [ListHazardAction].
  ListHazardActionProvider call({String filter = ""}) {
    return ListHazardActionProvider(filter: filter);
  }

  @override
  ListHazardActionProvider getProviderOverride(
    covariant ListHazardActionProvider provider,
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
  String? get name => r'listHazardActionProvider';
}

/// See also [ListHazardAction].
class ListHazardActionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ListHazardAction,
          List<HazardItemModel>
        > {
  /// See also [ListHazardAction].
  ListHazardActionProvider({String filter = ""})
    : this._internal(
        () => ListHazardAction()..filter = filter,
        from: listHazardActionProvider,
        name: r'listHazardActionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listHazardActionHash,
        dependencies: ListHazardActionFamily._dependencies,
        allTransitiveDependencies:
            ListHazardActionFamily._allTransitiveDependencies,
        filter: filter,
      );

  ListHazardActionProvider._internal(
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
    covariant ListHazardAction notifier,
  ) {
    return notifier.build(filter: filter);
  }

  @override
  Override overrideWith(ListHazardAction Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListHazardActionProvider._internal(
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
    ListHazardAction,
    List<HazardItemModel>
  >
  createElement() {
    return _ListHazardActionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListHazardActionProvider && other.filter == filter;
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
mixin ListHazardActionRef
    on AutoDisposeAsyncNotifierProviderRef<List<HazardItemModel>> {
  /// The parameter `filter` of this provider.
  String get filter;
}

class _ListHazardActionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ListHazardAction,
          List<HazardItemModel>
        >
    with ListHazardActionRef {
  _ListHazardActionProviderElement(super.provider);

  @override
  String get filter => (origin as ListHazardActionProvider).filter;
}

String _$updateActionHash() => r'62e358d7c421adc3bb9a87f55305ac8786000fc7';

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
String _$detailHazardActionHash() =>
    r'79985b46f9b02bf9b07e860667c89ce4764b146e';

abstract class _$DetailHazardAction
    extends BuildlessAutoDisposeAsyncNotifier<HazardModel> {
  late final String id;

  FutureOr<HazardModel> build({required String id});
}

/// See also [DetailHazardAction].
@ProviderFor(DetailHazardAction)
const detailHazardActionProvider = DetailHazardActionFamily();

/// See also [DetailHazardAction].
class DetailHazardActionFamily extends Family<AsyncValue<HazardModel>> {
  /// See also [DetailHazardAction].
  const DetailHazardActionFamily();

  /// See also [DetailHazardAction].
  DetailHazardActionProvider call({required String id}) {
    return DetailHazardActionProvider(id: id);
  }

  @override
  DetailHazardActionProvider getProviderOverride(
    covariant DetailHazardActionProvider provider,
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
  String? get name => r'detailHazardActionProvider';
}

/// See also [DetailHazardAction].
class DetailHazardActionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<DetailHazardAction, HazardModel> {
  /// See also [DetailHazardAction].
  DetailHazardActionProvider({required String id})
    : this._internal(
        () => DetailHazardAction()..id = id,
        from: detailHazardActionProvider,
        name: r'detailHazardActionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailHazardActionHash,
        dependencies: DetailHazardActionFamily._dependencies,
        allTransitiveDependencies:
            DetailHazardActionFamily._allTransitiveDependencies,
        id: id,
      );

  DetailHazardActionProvider._internal(
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
    covariant DetailHazardAction notifier,
  ) {
    return notifier.build(id: id);
  }

  @override
  Override overrideWith(DetailHazardAction Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailHazardActionProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DetailHazardAction, HazardModel>
  createElement() {
    return _DetailHazardActionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailHazardActionProvider && other.id == id;
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
mixin DetailHazardActionRef
    on AutoDisposeAsyncNotifierProviderRef<HazardModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DetailHazardActionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<DetailHazardAction, HazardModel>
    with DetailHazardActionRef {
  _DetailHazardActionProviderElement(super.provider);

  @override
  String get id => (origin as DetailHazardActionProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
