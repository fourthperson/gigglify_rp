import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gigglify_rp/domain/entity/joke.dart';

part 'joke_response.freezed.dart';

part 'joke_response.g.dart';

@freezed
abstract class JokeResponseModel with _$JokeResponseModel {
  const JokeResponseModel._();

  factory JokeResponseModel({
    required bool error,
    required String category,
    required String type,
    required String? joke,
    required String? setup,
    required String? delivery,
    required int id,
    required bool safe,
    required String lang,
  }) = _JokeResponseModel;

  factory JokeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JokeResponseModelFromJson(json);

  Joke toDomain() {
    return Joke(
      content: type == 'twopart' ? '$setup\n\n$delivery' : (joke ?? ''),
      category: category,
      time: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
