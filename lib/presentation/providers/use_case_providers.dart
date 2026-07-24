import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/domain/use_case/choice_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/choice_set_use_case.dart';
import 'package:gigglify_rp/domain/use_case/joke_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/joke_history_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/joke_save_use_case.dart';
import 'package:gigglify_rp/domain/use_case/theme_get_use_case.dart';
import 'package:gigglify_rp/domain/use_case/theme_set_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_case_providers.g.dart';

@riverpod
JokeGetUseCase jokeGetUseCase(Ref ref) => locator<JokeGetUseCase>();

@riverpod
JokeSaveUseCase jokeSaveUseCase(Ref ref) => locator<JokeSaveUseCase>();

@riverpod
JokeHistoryGetUseCase jokeHistoryGetUseCase(Ref ref) =>
    locator<JokeHistoryGetUseCase>();

@riverpod
ChoiceGetUseCase choiceGetUseCase(Ref ref) => locator<ChoiceGetUseCase>();

@riverpod
ChoiceSetUseCase choiceSetUseCase(Ref ref) => locator<ChoiceSetUseCase>();

@riverpod
ThemeSetUseCase themeSetUseCase(Ref ref) => locator<ThemeSetUseCase>();

@riverpod
ThemeGetUseCase themeGetUseCase(Ref ref) => locator<ThemeGetUseCase>();
