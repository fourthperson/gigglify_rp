import 'package:gigglify_rp/data/source/prefs/prefs_data_source.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';

class ChoiceRepositoryImpl extends ChoiceRepository {
  final List<String> apiPaths;
  final List<String> blacklistCategories;
  final PrefsDataSource prefsDataSource;

  ChoiceRepositoryImpl({
    required this.apiPaths,
    required this.blacklistCategories,
    required this.prefsDataSource,
  });

  @override
  Future<Choice> getChoice() async {
    final List<bool> choices = await prefsDataSource.getChoices();
    final List<int> blacklist = await prefsDataSource.getBlacklist();
    return Choice(choices: choices, blacklisted: blacklist);
  }

  @override
  Future<void> setChoice(Choice choice) async {
    await prefsDataSource.setChoices(choice.choices);
    await prefsDataSource.setBlackList(choice.blacklisted);
  }

  @override
  Future<String> getPath() async {
    Choice choice = await getChoice();

    final bool allFalse = choice.choices.where((c) => c == true).isEmpty;
    if (allFalse) {
      choice = Choice.defaultChoice();
      await setChoice(choice);
    }

    if (apiPaths.length != choice.choices.length) {
      return apiPaths[0];
    }

    // build comma-separated path from choices
    final List<String> categories = [];
    for (int i = 0; i < apiPaths.length; i++) {
      if (choice.choices[i]) {
        categories.add(apiPaths[i]);
      }
    }

    String path = categories.isEmpty ? apiPaths[0] : categories.join(',');

    if (choice.blacklisted.isNotEmpty) {
      final List<String> blacklist = [];
      for (int i = 0; i < choice.blacklisted.length; i++) {
        blacklist.add(blacklistCategories[choice.blacklisted[i]]);
      }
      path = '$path?blacklistFlags?=${blacklist.join(',')}';
    }

    return path;
  }
}
