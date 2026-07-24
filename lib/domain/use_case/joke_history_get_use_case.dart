import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class JokeHistoryGetUseCase {
  final JokeRepository _jokeRepository;

  JokeHistoryGetUseCase({required JokeRepository jokeRepository})
    : _jokeRepository = jokeRepository;

  Future<List<Joke>> invoke() async {
    return await _jokeRepository.getSavedJokes();
  }
}
