import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/use_case/get_joke_use_case.dart';
import 'package:gigglify_rp/domain/use_case/save_joke_use_case.dart';
import 'package:gigglify_rp/main.dart';

class JokeNotifier extends StateNotifier<AsyncValue<Joke?>> {
  final GetJokeUseCase _getUseCase;
  final SaveJokeUseCase _saveUseCase;

  JokeNotifier(this._getUseCase, this._saveUseCase)
    : super(const AsyncValue.loading());

  Future<void> fetchJoke() async {
    state = const AsyncValue.loading();
    final Joke? joke = await _getUseCase.invoke();
    if (joke != null) {
      _saveUseCase.invoke(joke);
    }
    state = AsyncValue.data(joke);
  }
}

final StateNotifierProvider<JokeNotifier, AsyncValue<Joke?>> jokeProvider =
    StateNotifierProvider<JokeNotifier, AsyncValue<Joke?>>((Ref ref) {
      return JokeNotifier(
        locator<GetJokeUseCase>(),
        locator<SaveJokeUseCase>(),
      );
    });
