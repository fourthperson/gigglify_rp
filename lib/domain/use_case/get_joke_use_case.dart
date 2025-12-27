import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';

class GetJokeUseCase {
  final JokeRepository _jokeRepository;
  final ChoiceRepository _choiceRepository;

  GetJokeUseCase(this._jokeRepository, this._choiceRepository);

  Future<Joke?> invoke() async {
    final String path = await _choiceRepository.getPath();
    if (path.trim().isEmpty) return null;
    return _jokeRepository.getJoke(path);
  }
}
