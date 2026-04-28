// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inspectionHistoryHash() => r'f94a8386f9f9fabee6fcd1d3014519c962378b62';

/// See also [InspectionHistory].
@ProviderFor(InspectionHistory)
final inspectionHistoryProvider =
    AutoDisposeAsyncNotifierProvider<
      InspectionHistory,
      List<InspectionListModel>
    >.internal(
      InspectionHistory.new,
      name: r'inspectionHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inspectionHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InspectionHistory =
    AutoDisposeAsyncNotifier<List<InspectionListModel>>;
String _$getInspectionHash() => r'43dc2a0e51421997ff41a3c7b1979bd1b3da1063';

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

abstract class _$GetInspection
    extends BuildlessAutoDisposeAsyncNotifier<List<InspectionQuestion>> {
  late final String slug;

  FutureOr<List<InspectionQuestion>> build({required String slug});
}

/// See also [GetInspection].
@ProviderFor(GetInspection)
const getInspectionProvider = GetInspectionFamily();

/// See also [GetInspection].
class GetInspectionFamily extends Family<AsyncValue<List<InspectionQuestion>>> {
  /// See also [GetInspection].
  const GetInspectionFamily();

  /// See also [GetInspection].
  GetInspectionProvider call({required String slug}) {
    return GetInspectionProvider(slug: slug);
  }

  @override
  GetInspectionProvider getProviderOverride(
    covariant GetInspectionProvider provider,
  ) {
    return call(slug: provider.slug);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getInspectionProvider';
}

/// See also [GetInspection].
class GetInspectionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GetInspection,
          List<InspectionQuestion>
        > {
  /// See also [GetInspection].
  GetInspectionProvider({required String slug})
    : this._internal(
        () => GetInspection()..slug = slug,
        from: getInspectionProvider,
        name: r'getInspectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$getInspectionHash,
        dependencies: GetInspectionFamily._dependencies,
        allTransitiveDependencies:
            GetInspectionFamily._allTransitiveDependencies,
        slug: slug,
      );

  GetInspectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
  }) : super.internal();

  final String slug;

  @override
  FutureOr<List<InspectionQuestion>> runNotifierBuild(
    covariant GetInspection notifier,
  ) {
    return notifier.build(slug: slug);
  }

  @override
  Override overrideWith(GetInspection Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetInspectionProvider._internal(
        () => create()..slug = slug,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    GetInspection,
    List<InspectionQuestion>
  >
  createElement() {
    return _GetInspectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetInspectionProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetInspectionRef
    on AutoDisposeAsyncNotifierProviderRef<List<InspectionQuestion>> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _GetInspectionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GetInspection,
          List<InspectionQuestion>
        >
    with GetInspectionRef {
  _GetInspectionProviderElement(super.provider);

  @override
  String get slug => (origin as GetInspectionProvider).slug;
}

String _$getInspectionTypeHash() => r'b10e4765b1bd96c8d0158f8c55bdbddd0f8a6865';

/// See also [GetInspectionType].
@ProviderFor(GetInspectionType)
final getInspectionTypeProvider =
    AutoDisposeAsyncNotifierProvider<
      GetInspectionType,
      List<InspectionType>
    >.internal(
      GetInspectionType.new,
      name: r'getInspectionTypeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getInspectionTypeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GetInspectionType = AutoDisposeAsyncNotifier<List<InspectionType>>;
String _$uploadInspectionHash() => r'8db934704bd6f5d1f10ffe281ef93b6ae1340c56';

/// See also [UploadInspection].
@ProviderFor(UploadInspection)
final uploadInspectionProvider =
    AutoDisposeAsyncNotifierProvider<UploadInspection, void>.internal(
      UploadInspection.new,
      name: r'uploadInspectionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uploadInspectionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UploadInspection = AutoDisposeAsyncNotifier<void>;
String _$detailInspectionHash() => r'3070ddd811914b5058bbd30b2e3c744439c8a4b0';

abstract class _$DetailInspection
    extends BuildlessAutoDisposeAsyncNotifier<InspectionDetail> {
  late final String id;

  FutureOr<InspectionDetail> build({required String id});
}

/// See also [DetailInspection].
@ProviderFor(DetailInspection)
const detailInspectionProvider = DetailInspectionFamily();

/// See also [DetailInspection].
class DetailInspectionFamily extends Family<AsyncValue<InspectionDetail>> {
  /// See also [DetailInspection].
  const DetailInspectionFamily();

  /// See also [DetailInspection].
  DetailInspectionProvider call({required String id}) {
    return DetailInspectionProvider(id: id);
  }

  @override
  DetailInspectionProvider getProviderOverride(
    covariant DetailInspectionProvider provider,
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
  String? get name => r'detailInspectionProvider';
}

/// See also [DetailInspection].
class DetailInspectionProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          DetailInspection,
          InspectionDetail
        > {
  /// See also [DetailInspection].
  DetailInspectionProvider({required String id})
    : this._internal(
        () => DetailInspection()..id = id,
        from: detailInspectionProvider,
        name: r'detailInspectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailInspectionHash,
        dependencies: DetailInspectionFamily._dependencies,
        allTransitiveDependencies:
            DetailInspectionFamily._allTransitiveDependencies,
        id: id,
      );

  DetailInspectionProvider._internal(
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
  FutureOr<InspectionDetail> runNotifierBuild(
    covariant DetailInspection notifier,
  ) {
    return notifier.build(id: id);
  }

  @override
  Override overrideWith(DetailInspection Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailInspectionProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DetailInspection, InspectionDetail>
  createElement() {
    return _DetailInspectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailInspectionProvider && other.id == id;
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
mixin DetailInspectionRef
    on AutoDisposeAsyncNotifierProviderRef<InspectionDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DetailInspectionProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          DetailInspection,
          InspectionDetail
        >
    with DetailInspectionRef {
  _DetailInspectionProviderElement(super.provider);

  @override
  String get id => (origin as DetailInspectionProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
