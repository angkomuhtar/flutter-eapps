// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pkwt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listContractHash() => r'2ff2365f8904acd5ae1c3130d37b8afddff759b3';

/// See also [ListContract].
@ProviderFor(ListContract)
final listContractProvider =
    AutoDisposeAsyncNotifierProvider<
      ListContract,
      List<ContractModel>
    >.internal(
      ListContract.new,
      name: r'listContractProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listContractHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListContract = AutoDisposeAsyncNotifier<List<ContractModel>>;
String _$signedContractHash() => r'b262db4547c88a06114af6943d0633a4d2470d77';

/// See also [SignedContract].
@ProviderFor(SignedContract)
final signedContractProvider =
    AutoDisposeAsyncNotifierProvider<SignedContract, void>.internal(
      SignedContract.new,
      name: r'signedContractProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$signedContractHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SignedContract = AutoDisposeAsyncNotifier<void>;
String _$latestContractHash() => r'42c22502540cf6ee5f6f4af6f799e3489e88894f';

/// See also [LatestContract].
@ProviderFor(LatestContract)
final latestContractProvider =
    AutoDisposeAsyncNotifierProvider<LatestContract, ContractModel?>.internal(
      LatestContract.new,
      name: r'latestContractProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$latestContractHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LatestContract = AutoDisposeAsyncNotifier<ContractModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
