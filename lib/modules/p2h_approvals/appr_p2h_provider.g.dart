// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appr_p2h_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listApprP2hHash() => r'f465cf8a82f9a20bd83e8ba99f8acc76233e9a92';

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

abstract class _$ListApprP2h
    extends BuildlessAutoDisposeAsyncNotifier<List<ApprP2hModel>> {
  late final String filter;

  FutureOr<List<ApprP2hModel>> build({String filter = ""});
}

/// See also [ListApprP2h].
@ProviderFor(ListApprP2h)
const listApprP2hProvider = ListApprP2hFamily();

/// See also [ListApprP2h].
class ListApprP2hFamily extends Family<AsyncValue<List<ApprP2hModel>>> {
  /// See also [ListApprP2h].
  const ListApprP2hFamily();

  /// See also [ListApprP2h].
  ListApprP2hProvider call({String filter = ""}) {
    return ListApprP2hProvider(filter: filter);
  }

  @override
  ListApprP2hProvider getProviderOverride(
    covariant ListApprP2hProvider provider,
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
  String? get name => r'listApprP2hProvider';
}

/// See also [ListApprP2h].
class ListApprP2hProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ListApprP2h, List<ApprP2hModel>> {
  /// See also [ListApprP2h].
  ListApprP2hProvider({String filter = ""})
    : this._internal(
        () => ListApprP2h()..filter = filter,
        from: listApprP2hProvider,
        name: r'listApprP2hProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$listApprP2hHash,
        dependencies: ListApprP2hFamily._dependencies,
        allTransitiveDependencies: ListApprP2hFamily._allTransitiveDependencies,
        filter: filter,
      );

  ListApprP2hProvider._internal(
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
  FutureOr<List<ApprP2hModel>> runNotifierBuild(
    covariant ListApprP2h notifier,
  ) {
    return notifier.build(filter: filter);
  }

  @override
  Override overrideWith(ListApprP2h Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListApprP2hProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ListApprP2h, List<ApprP2hModel>>
  createElement() {
    return _ListApprP2hProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListApprP2hProvider && other.filter == filter;
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
mixin ListApprP2hRef
    on AutoDisposeAsyncNotifierProviderRef<List<ApprP2hModel>> {
  /// The parameter `filter` of this provider.
  String get filter;
}

class _ListApprP2hProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ListApprP2h, List<ApprP2hModel>>
    with ListApprP2hRef {
  _ListApprP2hProviderElement(super.provider);

  @override
  String get filter => (origin as ListApprP2hProvider).filter;
}

String _$verifyP2hHash() => r'1a1532fb911e04adaba50ff8a6f99f3c02c9ae4a';

/// See also [VerifyP2h].
@ProviderFor(VerifyP2h)
final verifyP2hProvider =
    AutoDisposeAsyncNotifierProvider<VerifyP2h, void>.internal(
      VerifyP2h.new,
      name: r'verifyP2hProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$verifyP2hHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VerifyP2h = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
