// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sop_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listSopHash() => r'a06140caac6d58dce2e38dc882c1e5288a63f60f';

/// See also [ListSop].
@ProviderFor(ListSop)
final listSopProvider =
    AutoDisposeAsyncNotifierProvider<ListSop, List<ListSopModel>>.internal(
      ListSop.new,
      name: r'listSopProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listSopHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListSop = AutoDisposeAsyncNotifier<List<ListSopModel>>;
String _$sopDetailsHash() => r'504029924ae2259e36780c2d174b36739c28d493';

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

abstract class _$SopDetails
    extends BuildlessAutoDisposeAsyncNotifier<List<SopDetailsModel>> {
  late final String id;

  FutureOr<List<SopDetailsModel>> build(String id);
}

/// See also [SopDetails].
@ProviderFor(SopDetails)
const sopDetailsProvider = SopDetailsFamily();

/// See also [SopDetails].
class SopDetailsFamily extends Family<AsyncValue<List<SopDetailsModel>>> {
  /// See also [SopDetails].
  const SopDetailsFamily();

  /// See also [SopDetails].
  SopDetailsProvider call(String id) {
    return SopDetailsProvider(id);
  }

  @override
  SopDetailsProvider getProviderOverride(
    covariant SopDetailsProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sopDetailsProvider';
}

/// See also [SopDetails].
class SopDetailsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          SopDetails,
          List<SopDetailsModel>
        > {
  /// See also [SopDetails].
  SopDetailsProvider(String id)
    : this._internal(
        () => SopDetails()..id = id,
        from: sopDetailsProvider,
        name: r'sopDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sopDetailsHash,
        dependencies: SopDetailsFamily._dependencies,
        allTransitiveDependencies: SopDetailsFamily._allTransitiveDependencies,
        id: id,
      );

  SopDetailsProvider._internal(
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
  FutureOr<List<SopDetailsModel>> runNotifierBuild(
    covariant SopDetails notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(SopDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: SopDetailsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SopDetails, List<SopDetailsModel>>
  createElement() {
    return _SopDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SopDetailsProvider && other.id == id;
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
mixin SopDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<List<SopDetailsModel>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SopDetailsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          SopDetails,
          List<SopDetailsModel>
        >
    with SopDetailsRef {
  _SopDetailsProviderElement(super.provider);

  @override
  String get id => (origin as SopDetailsProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
