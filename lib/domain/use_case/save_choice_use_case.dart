import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';

class SaveChoiceUseCase {
  final ChoiceRepository _choiceRepository;

  SaveChoiceUseCase(this._choiceRepository);

  void invoke(Choice choices) {
    _choiceRepository.setChoice(choices);
  }
}
