import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';

class SaveJokeUseCase {
  final JokeRepository _jokeRepository;

  SaveJokeUseCase(this._jokeRepository);

  Future<void> invoke(Joke joke) async {
    await _jokeRepository.saveJoke(joke);
  }
}
