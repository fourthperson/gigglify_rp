import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/presentation/providers/use_case_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  FutureOr<List<Joke>> build() async {
    // Initial fetch happens automatically when the provider is first watched
    return ref.read(jokeHistoryGetUseCaseProvider).invoke();
  }

  Future<void> fetchHistory() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(jokeHistoryGetUseCaseProvider).invoke();
    });
  }
}
