import 'dart:convert';

import 'package:gigglify_rp/data/source/local/prefs/prefs_service.dart';
import 'package:gigglify_rp/domain/entity/choice.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class PrefsDataSource {
  Future<List<bool>> getChoices();

  Future<void> setChoices(List<bool> choices);

  Future<List<int>> getBlacklist();

  Future<void> setBlackList(List<int> blacklisted);
}

@LazySingleton(as: PrefsDataSource)
class PrefsDataSourceImpl extends PrefsDataSource {
  final PrefsService _prefsService;
  final Logger? _logger;

  final String choiceKey = 'choices';
  final String blacklistKey = 'blacklist';

  PrefsDataSourceImpl({
    required PrefsService prefsService,
    required Logger? logger,
  }) : _logger = logger,
       _prefsService = prefsService;

  @override
  Future<List<bool>> getChoices() async {
    try {
      final String? json = await _prefsService.getItem(choiceKey);
      List<bool> choices = [];
      if (json != null && json.isNotEmpty) {
        final List<dynamic> list = jsonDecode(json) as List;
        for (int i = 0; i < list.length; i++) {
          choices.add(bool.tryParse(list[i].toString()) ?? false);
        }
        return choices;
      } else {
        choices = Choice.defaultChoice().choices;
        await setChoices(choices);
      }

      final bool allFalse = choices.where((c) => c == true).isEmpty;
      if (allFalse) {
        choices = Choice.defaultChoice().choices;
        await setChoices(choices);
      }
      _logger?.i('getChoices: $choices');
      return choices;
    } catch (e) {
      _logger?.e(e);
      return [];
    }
  }

  @override
  Future<void> setChoices(List<bool> choices) async {
    try {
      _logger?.i('setChoices: $choices');
      final String json = jsonEncode(choices);
      await _prefsService.setItem(choiceKey, json);
    } catch (e) {
      _logger?.e(e);
    }
  }

  @override
  Future<List<int>> getBlacklist() async {
    try {
      final String? json = await _prefsService.getItem(blacklistKey);
      final List<int> blacklisted = [];
      if (json != null && json.isNotEmpty) {
        final List<dynamic> list = jsonDecode(json) as List<dynamic>;
        for (int i = 0; i < list.length; i++) {
          blacklisted.add(int.tryParse(list[i].toString()) ?? 0);
        }
      }
      _logger?.i('getBlacklist: $blacklisted');
      return blacklisted;
    } catch (e) {
      _logger?.e(e);
      return [];
    }
  }

  @override
  Future<void> setBlackList(List<int> blacklisted) async {
    try {
      _logger?.i('setBlackList: $blacklisted');
      final String json = jsonEncode(blacklisted);
      await _prefsService.setItem(blacklistKey, json);
    } catch (e) {
      _logger?.e(e);
    }
  }
}
