import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';

class GetSavedJokesUseCase {
  final JokeRepository _jokeRepository;

  GetSavedJokesUseCase(this._jokeRepository);

  Future<List<Joke>> invoke() async {
    return _jokeRepository.getSavedJokes();
  }
}
