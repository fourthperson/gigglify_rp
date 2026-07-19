import 'package:gigglify_rp/data/source/prefs/prefs_data_source.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';

class ChoiceRepositoryImpl extends ChoiceRepository {
  final List<String> _apiPaths;
  final List<String> _blacklistCategories;
  final PrefsDataSource _prefsDataSource;

  ChoiceRepositoryImpl(
    this._apiPaths,
    this._blacklistCategories,
    this._prefsDataSource,
  );

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

    if (_apiPaths.length != choice.choices.length) {
      return _apiPaths[0];
    }

    // build comma-separated path from choices
    final List<String> categories = [];
    for (int i = 0; i < _apiPaths.length; i++) {
      if (choice.choices[i]) {
        categories.add(_apiPaths[i]);
      }
    }

    String path = categories.isEmpty ? _apiPaths[0] : categories.join(',');

    if (choice.blacklisted.isNotEmpty) {
      final List<String> blacklist = [];
      for (int i = 0; i < choice.blacklisted.length; i++) {
        blacklist.add(_blacklistCategories[choice.blacklisted[i]]);
      }
      path = '$path?blacklistFlags?=${blacklist.join(',')}';
    }

    return path;
  }
}
