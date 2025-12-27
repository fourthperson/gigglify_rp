import 'package:gigglify_rp/data/entity/db/saved_joke.dart';
import 'package:gigglify_rp/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class GigDb {
  late final Store store;

  late final Box<SavedJoke> savedJokeBox;

  GigDb._create(this.store) {
    savedJokeBox = Box<SavedJoke>(store);
  }

  static Future<GigDb> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, 'dig_db'));
    return GigDb._create(store);
  }
}
