import 'package:gigglify_rp/data/entity/api/joke_response.dart';
import 'package:gigglify_rp/data/source/api/api_data_source.dart';
import 'package:gigglify_rp/data/source/db/db_data_source.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';

import 'package:gigglify_rp/data/entity/db/saved_joke.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

// @LazySingleton(as: JokeRepository)
class JokeRepositoryImpl extends JokeRepository {
  final ApiDataSource apiDataSource;
  final DatabaseDataSource databaseDataSource;
  final Logger? logger;

  JokeRepositoryImpl({
    required this.apiDataSource,
    required this.databaseDataSource,
    required this.logger,
  });

  @override
  Future<Joke?> getJoke(String path) async {
    final JokeResponseModel? apiModel = await apiDataSource.getJoke(path);

    if (apiModel == null) return null;

    return apiModel.toDomain();
  }

  @override
  Future<void> saveJoke(Joke joke) async {
    await databaseDataSource.saveJoke(joke);
  }

  @override
  Future<List<Joke>> getSavedJokes() async {
    final List<Joke> jokes = [];
    try {
      final List<SavedJoke> saved = await databaseDataSource.getSavedJokes();
      for (int i = 0; i < saved.length; i++) {
        jokes.add(saved[i].toDomain());
      }
    } catch (e) {
      logger?.log(Level.error, e);
    }
    return jokes;
  }
}
