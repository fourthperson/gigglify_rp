import 'package:gigglify_rp/data/model/api/joke_response.dart';
import 'package:gigglify_rp/data/model/db/saved_joke.dart';
import 'package:gigglify_rp/data/source/local/db/db_data_source.dart';
import 'package:gigglify_rp/data/source/remote/api/api_data_source.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: JokeRepository)
class JokeRepositoryImpl extends JokeRepository {
  final ApiDataSource _apiDataSource;
  final DatabaseDataSource _databaseDataSource;
  final Logger? _logger;

  JokeRepositoryImpl({
    required ApiDataSource apiDataSource,
    required DatabaseDataSource databaseDataSource,
    required Logger? logger,
  }) : _logger = logger,
       _databaseDataSource = databaseDataSource,
       _apiDataSource = apiDataSource;

  @override
  Future<Joke?> getJoke(String path) async {
    final JokeResponseModel? apiModel = await _apiDataSource.getJoke(path);

    if (apiModel == null) return null;

    return apiModel.toDomain();
  }

  @override
  Future<void> saveJoke(Joke joke) async {
    await _databaseDataSource.saveJoke(joke);
  }

  @override
  Future<List<Joke>> getSavedJokes() async {
    final List<Joke> jokes = [];
    try {
      final List<SavedJoke> saved = await _databaseDataSource.getSavedJokes();
      for (int i = 0; i < saved.length; i++) {
        jokes.add(saved[i].toDomain());
      }
    } catch (e) {
      _logger?.e(e);
    }
    return jokes;
  }
}
