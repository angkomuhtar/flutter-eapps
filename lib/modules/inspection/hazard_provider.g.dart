// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listHazardHash() => r'8689ba952e4fef62a80112f42353765549a1b8b9';

/// See also [ListHazard].
@ProviderFor(ListHazard)
final listHazardProvider =
    AutoDisposeAsyncNotifierProvider<
      ListHazard,
      List<HazardItemModel>
    >.internal(
      ListHazard.new,
      name: r'listHazardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listHazardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListHazard = AutoDisposeAsyncNotifier<List<HazardItemModel>>;
String _$uploadHazardHash() => r'6f0739e7f08ccdb72d7bbf4865f18854ac2d992e';

/// See also [UploadHazard].
@ProviderFor(UploadHazard)
final uploadHazardProvider =
    AutoDisposeAsyncNotifierProvider<UploadHazard, void>.internal(
      UploadHazard.new,
      name: r'uploadHazardProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$uploadHazardHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UploadHazard = AutoDisposeAsyncNotifier<void>;
String _$detailHazardHash() => r'90422f4bdd8c207f2c0bedc62e353edc8f2d034c';

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

abstract class _$DetailHazard
    extends BuildlessAutoDisposeAsyncNotifier<HazardModel> {
  late final String id;

  FutureOr<HazardModel> build({required String id});
}

/// See also [DetailHazard].
@ProviderFor(DetailHazard)
const detailHazardProvider = DetailHazardFamily();

/// See also [DetailHazard].
class DetailHazardFamily extends Family<AsyncValue<HazardModel>> {
  /// See also [DetailHazard].
  const DetailHazardFamily();

  /// See also [DetailHazard].
  DetailHazardProvider call({required String id}) {
    return DetailHazardProvider(id: id);
  }

  @override
  DetailHazardProvider getProviderOverride(
    covariant DetailHazardProvider provider,
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
  String? get name => r'detailHazardProvider';
}

/// See also [DetailHazard].
class DetailHazardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DetailHazard, HazardModel> {
  /// See also [DetailHazard].
  DetailHazardProvider({required String id})
    : this._internal(
        () => DetailHazard()..id = id,
        from: detailHazardProvider,
        name: r'detailHazardProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$detailHazardHash,
        dependencies: DetailHazardFamily._dependencies,
        allTransitiveDependencies:
            DetailHazardFamily._allTransitiveDependencies,
        id: id,
      );

  DetailHazardProvider._internal(
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
  FutureOr<HazardModel> runNotifierBuild(covariant DetailHazard notifier) {
    return notifier.build(id: id);
  }

  @override
  Override overrideWith(DetailHazard Function() create) {
    return ProviderOverride(
      origin: this,
      override: DetailHazardProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<DetailHazard, HazardModel>
  createElement() {
    return _DetailHazardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailHazardProvider && other.id == id;
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
mixin DetailHazardRef on AutoDisposeAsyncNotifierProviderRef<HazardModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DetailHazardProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DetailHazard, HazardModel>
    with DetailHazardRef {
  _DetailHazardProviderElement(super.provider);

  @override
  String get id => (origin as DetailHazardProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
