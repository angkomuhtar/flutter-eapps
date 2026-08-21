// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2h_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getP2hInspectionHash() => r'a576b7d73993bb22607d0a0dab1bbe4a930df5b2';

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

abstract class _$GetP2hInspection
    extends BuildlessAutoDisposeAsyncNotifier<List<P2hHeader>> {
  late final String id_unit;

  FutureOr<List<P2hHeader>> build(String id_unit);
}

/// See also [GetP2hInspection].
@ProviderFor(GetP2hInspection)
const getP2hInspectionProvider = GetP2hInspectionFamily();

/// See also [GetP2hInspection].
class GetP2hInspectionFamily extends Family<AsyncValue<List<P2hHeader>>> {
  /// See also [GetP2hInspection].
  const GetP2hInspectionFamily();

  /// See also [GetP2hInspection].
  GetP2hInspectionProvider call(String id_unit) {
    return GetP2hInspectionProvider(id_unit);
  }

  @override
  GetP2hInspectionProvider getProviderOverride(
    covariant GetP2hInspectionProvider provider,
  ) {
    return call(provider.id_unit);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getP2hInspectionProvider';
}

/// See also [GetP2hInspection].
class GetP2hInspectionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GetP2hInspection,
          List<P2hHeader>
        > {
  /// See also [GetP2hInspection].
  GetP2hInspectionProvider(String id_unit)
    : this._internal(
        () => GetP2hInspection()..id_unit = id_unit,
        from: getP2hInspectionProvider,
        name: r'getP2hInspectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getP2hInspectionHash,
        dependencies: GetP2hInspectionFamily._dependencies,
        allTransitiveDependencies:
            GetP2hInspectionFamily._allTransitiveDependencies,
        id_unit: id_unit,
      );

  GetP2hInspectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id_unit,
  }) : super.internal();

  final String id_unit;

  @override
  FutureOr<List<P2hHeader>> runNotifierBuild(
    covariant GetP2hInspection notifier,
  ) {
    return notifier.build(id_unit);
  }

  @override
  Override overrideWith(GetP2hInspection Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetP2hInspectionProvider._internal(
        () => create()..id_unit = id_unit,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id_unit: id_unit,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GetP2hInspection, List<P2hHeader>>
  createElement() {
    return _GetP2hInspectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetP2hInspectionProvider && other.id_unit == id_unit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id_unit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetP2hInspectionRef
    on AutoDisposeAsyncNotifierProviderRef<List<P2hHeader>> {
  /// The parameter `id_unit` of this provider.
  String get id_unit;
}

class _GetP2hInspectionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GetP2hInspection,
          List<P2hHeader>
        >
    with GetP2hInspectionRef {
  _GetP2hInspectionProviderElement(super.provider);

  @override
  String get id_unit => (origin as GetP2hInspectionProvider).id_unit;
}

String _$submitP2hHash() => r'695815f9424271e0ce50df82d37418948a91754b';

/// See also [SubmitP2h].
@ProviderFor(SubmitP2h)
final submitP2hProvider =
    AutoDisposeAsyncNotifierProvider<SubmitP2h, void>.internal(
      SubmitP2h.new,
      name: r'submitP2hProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$submitP2hHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SubmitP2h = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
