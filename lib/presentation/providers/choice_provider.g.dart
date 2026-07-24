// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChoiceNotifier)
final choiceProvider = ChoiceNotifierProvider._();

final class ChoiceNotifierProvider
    extends $AsyncNotifierProvider<ChoiceNotifier, Choice> {
  ChoiceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'choiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$choiceNotifierHash();

  @$internal
  @override
  ChoiceNotifier create() => ChoiceNotifier();
}

String _$choiceNotifierHash() => r'25059efb9fc23178b447bb0bca0c14e050aad2b6';

abstract class _$ChoiceNotifier extends $AsyncNotifier<Choice> {
  FutureOr<Choice> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Choice>, Choice>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Choice>, Choice>,
              AsyncValue<Choice>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
