// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listActivityHash() => r'23b41c60768572c6bdba2aa357064f9b1c2e97dd';

/// See also [ListActivity].
@ProviderFor(ListActivity)
final listActivityProvider =
    AutoDisposeAsyncNotifierProvider<
      ListActivity,
      List<DailyActivityModel>
    >.internal(
      ListActivity.new,
      name: r'listActivityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$listActivityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ListActivity = AutoDisposeAsyncNotifier<List<DailyActivityModel>>;
String _$saveActivityHash() => r'4131965600bc03e74ebe5448857075cb3c366fd9';

/// See also [SaveActivity].
@ProviderFor(SaveActivity)
final saveActivityProvider =
    AutoDisposeAsyncNotifierProvider<SaveActivity, void>.internal(
      SaveActivity.new,
      name: r'saveActivityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$saveActivityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SaveActivity = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
