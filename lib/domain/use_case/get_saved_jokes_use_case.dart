import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSavedJokesUseCase {
  final JokeRepository _jokeRepository;

  GetSavedJokesUseCase({required JokeRepository jokeRepository})
    : _jokeRepository = jokeRepository;

  Future<List<Joke>> invoke() async {
    return await _jokeRepository.getSavedJokes();
  }
}
