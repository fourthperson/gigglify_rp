import 'package:gigglify_rp/data/model/db/saved_joke.dart';
import 'package:gigglify_rp/data/source/local/db/gig_db.dart';
import 'package:gigglify_rp/data/source/local/db/objectbox.g.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';

import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

abstract class DatabaseDataSource {
  Future<void> saveJoke(Joke joke);

  Future<List<SavedJoke>> getSavedJokes();
}

@LazySingleton(as: DatabaseDataSource)
class DatabaseDataSourceImpl extends DatabaseDataSource {
  final GigDb _gigDb;
  final Logger? _logger;

  DatabaseDataSourceImpl({required GigDb gigDb, required Logger? logger})
    : _gigDb = gigDb,
      _logger = logger;

  @override
  Future<List<SavedJoke>> getSavedJokes() async {
    try {
      final Query<SavedJoke> query = _gigDb.savedJokeBox
          .query()
          .order(SavedJoke_.time, flags: Order.descending)
          .build();

      final List<SavedJoke> jokes = query.find();
      query.close();

      return jokes;
    } catch (e) {
      _logger?.e(e);
      return [];
    }
  }

  @override
  Future<void> saveJoke(Joke joke) async {
    try {
      final SavedJoke sj = SavedJoke(
        time: joke.time,
        joke: joke.content,
        category: joke.category,
      );

      _gigDb.savedJokeBox.put(sj);
    } catch (e) {
      _logger?.e(e);
    }
  }
}
