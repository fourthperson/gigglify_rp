import 'package:gigglify_rp/data/source/local/prefs/prefs_data_source.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/entity/core/config.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChoiceRepository)
class ChoiceRepositoryImpl extends ChoiceRepository {
  final AppConfig _config;
  final PrefsDataSource _prefsDataSource;

  ChoiceRepositoryImpl({
    required AppConfig config,
    required PrefsDataSource prefsDataSource,
  }) : _prefsDataSource = prefsDataSource,
       _config = config;

  @override
  Future<Choice> getChoice() async {
    final List<bool> choices = await _prefsDataSource.getChoices();
    final List<int> blacklist = await _prefsDataSource.getBlacklist();
    return Choice(choices: choices, blacklisted: blacklist);
  }

  @override
  Future<void> setChoice(Choice choice) async {
    await _prefsDataSource.setChoices(choice.choices);
    await _prefsDataSource.setBlackList(choice.blacklisted);
  }

  @override
  Future<String> getPath() async {
    Choice choice = await getChoice();

    final bool allFalse = choice.choices.where((c) => c == true).isEmpty;
    if (allFalse) {
      choice = Choice.defaultChoice();
      await setChoice(choice);
    }

    if (_config.categories.length != choice.choices.length) {
      return _config.categories[0];
    }

    // build comma-separated path from choices
    final List<String> categories = [];
    for (int i = 0; i < _config.categories.length; i++) {
      if (choice.choices[i]) {
        categories.add(_config.categories[i]);
      }
    }

    String path = categories.isEmpty
        ? _config.categories[0]
        : categories.join(',');

    if (choice.blacklisted.isNotEmpty) {
      final List<String> blacklist = [];
      for (int i = 0; i < choice.blacklisted.length; i++) {
        blacklist.add(_config.blacklistable[choice.blacklisted[i]]);
      }
      path = '$path?blacklistFlags?=${blacklist.join(',')}';
    }

    return path;
  }
}
