import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class JokeGetUseCase {
  final JokeRepository _jokeRepository;
  final ChoiceRepository _choiceRepository;

  JokeGetUseCase({
    required JokeRepository jokeRepository,
    required ChoiceRepository choiceRepository,
  }) : _jokeRepository = jokeRepository,
       _choiceRepository = choiceRepository;

  Future<Joke?> invoke() async {
    final String path = await _choiceRepository.getPath();
    if (path.trim().isEmpty) return null;
    return await _jokeRepository.getJoke(path);
  }
}
