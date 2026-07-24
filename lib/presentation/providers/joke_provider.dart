import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/providers/use_case_providers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'joke_provider.g.dart';

@riverpod
class JokeNotifier extends _$JokeNotifier {
  @override
  FutureOr<Joke?> build() {
    return null;
  }

  Future<void> fetchJoke() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final Joke? joke = await ref.read(jokeGetUseCaseProvider).invoke();
      if (joke != null) {
        await ref.read(jokeSaveUseCaseProvider).invoke(joke);
      }
      return joke;
    });
  }

  Future<void> shareJoke(String content) async {
    await SharePlus.instance.share(ShareParams(text: content));
  }
}
