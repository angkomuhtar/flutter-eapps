// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pkwt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listContractHash() => r'3ca0e28eb73c831812418507fde5bbdecba281d2';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
