import 'package:equatable/equatable.dart';

class Joke extends Equatable {
  final int time;
  final String content;
  final String category;

  const Joke({
    required this.time,
    required this.content,
    required this.category,
  });

  @override
  List<Object?> get props => [time, content, category];
}
