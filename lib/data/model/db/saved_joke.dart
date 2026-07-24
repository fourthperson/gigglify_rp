import 'package:gigglify_rp/domain/entity/joke.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class SavedJoke {
  int id = 0;
  late int time;
  late String joke;
  late String category;

  SavedJoke({required this.time, required this.joke, required this.category});

  Joke toDomain() {
    return Joke(time: time, content: joke, category: category);
  }
}
