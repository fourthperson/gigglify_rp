// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:gigglify_rp/data/repo/choice_repo_impl.dart' as _i1022;
import 'package:gigglify_rp/data/repo/joke_repo_impl.dart' as _i921;
import 'package:gigglify_rp/data/source/api/api_data_source.dart' as _i811;
import 'package:gigglify_rp/data/source/db/db_data_source.dart' as _i463;
import 'package:gigglify_rp/data/source/db/gig_db.dart' as _i570;
import 'package:gigglify_rp/data/source/prefs/prefs_data_source.dart' as _i107;
import 'package:gigglify_rp/data/source/services/prefs_service.dart' as _i436;
import 'package:gigglify_rp/data/source/services/rest_service.dart' as _i681;
import 'package:gigglify_rp/di.dart' as _i275;
import 'package:gigglify_rp/domain/entity/core/config.dart' as _i264;
import 'package:gigglify_rp/domain/repository/choice_repository.dart' as _i480;
import 'package:gigglify_rp/domain/repository/joke_repository.dart' as _i216;
import 'package:gigglify_rp/domain/use_case/get_choice_use_case.dart' as _i450;
import 'package:gigglify_rp/domain/use_case/get_joke_use_case.dart' as _i841;
import 'package:gigglify_rp/domain/use_case/get_saved_jokes_use_case.dart'
    as _i123;
import 'package:gigglify_rp/domain/use_case/save_choice_use_case.dart' as _i550;
import 'package:gigglify_rp/domain/use_case/save_joke_use_case.dart' as _i1019;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final gigglifyModule = _$GigglifyModule();
    gh.singleton<_i264.AppConfig>(() => gigglifyModule.config);
    gh.lazySingleton<_i974.Logger>(() => gigglifyModule.logger);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => gigglifyModule.flutterSecureStorage,
    );
    await gh.lazySingletonAsync<_i570.GigDb>(
      () => gigglifyModule.gigDb(),
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i436.PrefsService>(
      () => gigglifyModule.prefsService(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => gigglifyModule.dio());
    gh.lazySingleton<_i463.DatabaseDataSource>(
      () => _i463.DatabaseDataSourceImpl(
        gigDb: gh<_i570.GigDb>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i107.PrefsDataSource>(
      () => _i107.PrefsDataSourceImpl(
        prefsService: gh<_i436.PrefsService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i681.RestService>(
      () => _i681.RestService(dio: gh<_i361.Dio>(), logger: gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i811.ApiDataSource>(
      () => _i811.ApiDataSourceImpl(
        restService: gh<_i681.RestService>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i480.ChoiceRepository>(
      () => _i1022.ChoiceRepositoryImpl(
        config: gh<_i264.AppConfig>(),
        prefsDataSource: gh<_i107.PrefsDataSource>(),
      ),
    );
    gh.lazySingleton<_i216.JokeRepository>(
      () => _i921.JokeRepositoryImpl(
        apiDataSource: gh<_i811.ApiDataSource>(),
        databaseDataSource: gh<_i463.DatabaseDataSource>(),
        logger: gh<_i974.Logger>(),
      ),
    );
    gh.lazySingleton<_i123.GetSavedJokesUseCase>(
      () => _i123.GetSavedJokesUseCase(
        jokeRepository: gh<_i216.JokeRepository>(),
      ),
    );
    gh.lazySingleton<_i1019.SaveJokeUseCase>(
      () => _i1019.SaveJokeUseCase(jokeRepository: gh<_i216.JokeRepository>()),
    );
    gh.lazySingleton<_i450.GetChoiceUseCase>(
      () => _i450.GetChoiceUseCase(
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    gh.lazySingleton<_i550.SaveChoiceUseCase>(
      () => _i550.SaveChoiceUseCase(
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    gh.lazySingleton<_i841.GetJokeUseCase>(
      () => _i841.GetJokeUseCase(
        jokeRepository: gh<_i216.JokeRepository>(),
        choiceRepository: gh<_i480.ChoiceRepository>(),
      ),
    );
    return this;
  }
}

class _$GigglifyModule extends _i275.GigglifyModule {}
