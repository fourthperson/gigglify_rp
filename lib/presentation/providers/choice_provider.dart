import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/use_case/choice_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/choice_set_use_case.dart';

class ChoiceNotifier extends StateNotifier<AsyncValue<Choice>> {
  final ChoiceGetUseCase _getUseCase;
  final ChoiceSetUseCase _saveUseCase;

  ChoiceNotifier(this._getUseCase, this._saveUseCase)
    : super(const AsyncValue.loading());

  void getChoice() async {
    state = const AsyncValue.loading();
    try {
      final Choice choice = await _getUseCase.invoke();
      state = AsyncValue.data(choice);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveChoice(Choice newChoice) async {
    // Store the current state to revert if the save fails
    final AsyncValue<Choice> previousState = state;

    // Optimistically update the UI
    state = AsyncValue.data(newChoice);

    try {
      await _saveUseCase.invoke(newChoice);
    } catch (e, st) {
      // Revert UI
      state = previousState;
      state = AsyncValue.error(e, st);
    }
  }
}

final StateNotifierProvider<ChoiceNotifier, AsyncValue<Choice>> choiceNotifier =
    StateNotifierProvider<ChoiceNotifier, AsyncValue<Choice>>((Ref ref) {
      return ChoiceNotifier(
        locator<ChoiceGetUseCase>(),
        locator<ChoiceSetUseCase>(),
      );
    });
