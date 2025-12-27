import 'package:gigglify_rp/domain/entity/joke.dart';

abstract class JokeRepository {
  Future<Joke?> getJoke(String path);

  Future<void> saveJoke(Joke joke);

  Future<List<Joke>> getSavedJokes();
}
