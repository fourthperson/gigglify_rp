import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveJokeUseCase {
  final JokeRepository _jokeRepository;

  SaveJokeUseCase({required JokeRepository jokeRepository})
    : _jokeRepository = jokeRepository;

  Future<void> invoke(Joke joke) async {
    await _jokeRepository.saveJoke(joke);
  }
}
