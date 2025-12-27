import 'package:equatable/equatable.dart';

class Choice extends Equatable {
  final List<bool> choices;
  final List<String> blacklisted;

  const Choice({required this.choices, required this.blacklisted});

  @override
  List<Object?> get props => [choices];

  Choice copyWith({List<bool>? choices, List<String>? blacklisted}) {
    return Choice(
      choices: choices ?? this.choices,
      blacklisted: blacklisted ?? this.blacklisted,
    );
  }

  factory Choice.defaultChoice() {
    return Choice(
      choices: [true, false, false, false, false, false, false],
      blacklisted: [],
    );
  }
}
