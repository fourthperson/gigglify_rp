import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChoiceSetUseCase {
  final ChoiceRepository _choiceRepository;

  ChoiceSetUseCase({required ChoiceRepository choiceRepository})
    : _choiceRepository = choiceRepository;

  Future<void> invoke(Choice choices) async {
    await _choiceRepository.setChoice(choices);
  }
}
