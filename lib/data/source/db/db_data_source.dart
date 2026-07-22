import 'package:gigglify_rp/data/entity/db/saved_joke.dart';
import 'package:gigglify_rp/data/source/db/objectbox.g.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';

import 'package:gigglify_rp/data/source/db/gig_db.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:logger/logger.dart';

abstract class DatabaseDataSource {
  Future<void> saveJoke(Joke joke);

  Future<List<SavedJoke>> getSavedJokes();
}

@LazySingleton(as: DatabaseDataSource)
class DatabaseDataSourceImpl extends DatabaseDataSource {
  final GigDb _gigDb;
  final Logger? logger;

  DatabaseDataSourceImpl({required GigDb gigDb, required this.logger})
    : _gigDb = gigDb;

  @override
  Future<List<SavedJoke>> getSavedJokes() async {
    final Query<SavedJoke> query = _gigDb.savedJokeBox
        .query()
        .order(SavedJoke_.time, flags: Order.descending)
        .build();

    final List<SavedJoke> jokes = query.find();
    query.close();

    return jokes;
  }

  @override
  Future<void> saveJoke(Joke joke) async {
    final SavedJoke sj = SavedJoke(
      time: joke.time,
      joke: joke.content,
      category: joke.category,
    );

    _gigDb.savedJokeBox.put(sj);
  }
}
