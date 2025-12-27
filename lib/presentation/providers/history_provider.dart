import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/use_case/get_saved_jokes_use_case.dart';
import 'package:gigglify_rp/main.dart';

class HistoryNotifier extends StateNotifier<AsyncValue<List<Joke>>> {
  final GetSavedJokesUseCase _getUseCase;

  HistoryNotifier(this._getUseCase) : super(const AsyncValue.loading());

  Future<void> fetchHistory() async {
    state = AsyncValue.loading();
    final List<Joke> jokes = await _getUseCase.invoke();
    state = AsyncValue.data(jokes);
  }
}

final StateNotifierProvider<HistoryNotifier, AsyncValue<List<Joke>>>
historyProvider =
    StateNotifierProvider<HistoryNotifier, AsyncValue<List<Joke>>>((Ref ref) {
      return HistoryNotifier(locator<GetSavedJokesUseCase>());
    });
