// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JokeNotifier)
final jokeProvider = JokeNotifierProvider._();

final class JokeNotifierProvider
    extends $AsyncNotifierProvider<JokeNotifier, Joke?> {
  JokeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jokeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jokeNotifierHash();

  @$internal
  @override
  JokeNotifier create() => JokeNotifier();
}

String _$jokeNotifierHash() => r'9b80d391489df28be02b91edd808bed6047d8f7a';

abstract class _$JokeNotifier extends $AsyncNotifier<Joke?> {
  FutureOr<Joke?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Joke?>, Joke?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Joke?>, Joke?>,
              AsyncValue<Joke?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
