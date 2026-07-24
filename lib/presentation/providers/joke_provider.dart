import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/use_case/joke_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/joke_save_use_case.dart';
import 'package:share_plus/share_plus.dart';

class JokeNotifier extends StateNotifier<AsyncValue<Joke?>> {
  final JokeGetUseCase _getUseCase;
  final JokeSaveUseCase _saveUseCase;

  JokeNotifier(this._getUseCase, this._saveUseCase)
    : super(const AsyncValue.loading());

  Future<void> fetchJoke() async {
    state = const AsyncValue.loading();
    final Joke? joke = await _getUseCase.invoke();
    if (joke != null) {
      await _saveUseCase.invoke(joke);
    }
    state = AsyncValue.data(joke);
  }

  Future<void> shareJoke(String content) async {
    await SharePlus.instance.share(ShareParams(text: content));
  }
}

final StateNotifierProvider<JokeNotifier, AsyncValue<Joke?>> jokeProvider =
    StateNotifierProvider<JokeNotifier, AsyncValue<Joke?>>((Ref ref) {
      return JokeNotifier(
        locator<JokeGetUseCase>(),
        locator<JokeSaveUseCase>(),
      );
    });
