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
    final Choice choice = await _getUseCase.invoke();
    state = AsyncValue.data(choice);
  }

  void saveChoice(Choice choice) async {
    state = AsyncValue.loading();
    await _saveUseCase.invoke(choice);
    state = AsyncValue.data(choice);
  }
}

final StateNotifierProvider<ChoiceNotifier, AsyncValue<Choice>> choiceNotifier =
    StateNotifierProvider<ChoiceNotifier, AsyncValue<Choice>>((Ref ref) {
      return ChoiceNotifier(
        locator<ChoiceGetUseCase>(),
        locator<ChoiceSetUseCase>(),
      );
    });
