import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChoiceGetUseCase {
  final ChoiceRepository _choiceRepository;

  ChoiceGetUseCase({required ChoiceRepository choiceRepository})
    : _choiceRepository = choiceRepository;

  Future<Choice> invoke() async {
    return await _choiceRepository.getChoice();
  }
}
