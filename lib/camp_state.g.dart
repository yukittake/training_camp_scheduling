// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camp_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CampStateNotifier)
const campStateNotifierProvider = CampStateNotifierProvider._();

final class CampStateNotifierProvider
    extends $NotifierProvider<CampStateNotifier, List<TrainingCamp>> {
  const CampStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campStateNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campStateNotifierHash();

  @$internal
  @override
  CampStateNotifier create() => CampStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TrainingCamp> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TrainingCamp>>(value),
    );
  }
}

String _$campStateNotifierHash() => r'1c7e446eda1f76a78961a4b37244cb50958c3952';

abstract class _$CampStateNotifier extends $Notifier<List<TrainingCamp>> {
  List<TrainingCamp> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<TrainingCamp>, List<TrainingCamp>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TrainingCamp>, List<TrainingCamp>>,
              List<TrainingCamp>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
