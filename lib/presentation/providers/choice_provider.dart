import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/presentation/providers/use_case_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'choice_provider.g.dart';

@riverpod
class ChoiceNotifier extends _$ChoiceNotifier {
  @override
  FutureOr<Choice> build() async {
    // Returning the initial fetch directly inside build() initializes
    // the state as AsyncValue.loading() automatically while loading!
    return ref.read(choiceGetUseCaseProvider).invoke();
  }

  Future<void> getChoice() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(choiceGetUseCaseProvider).invoke();
    });
  }

  Future<void> saveChoice(Choice newChoice) async {
    // Preserve current state for optimistic rollback
    final previousState = state;

    // Optimistically update state
    state = AsyncValue.data(newChoice);

    try {
      await ref.read(choiceSetUseCaseProvider).invoke(newChoice);
    } catch (e, st) {
      // Revert back to previous state before setting error
      state = previousState;
      state = AsyncValue.error(e, st);
    }
  }
}
